"""Live health and one owned free-quota final-slot check. Leaves billed global usage intact."""
import concurrent.futures
import datetime
import json
from pathlib import Path
import subprocess
import urllib.error
import urllib.request
import uuid

ROOT = Path(__file__).resolve().parent.parent
SERVER = ROOT / "server"
WRANGLER = SERVER / "node_modules/wrangler/bin/wrangler.js"
URL = "https://nshoptor-api.devx8585.workers.dev"


def sql(command):
    result = subprocess.run(["node", str(WRANGLER), "d1", "execute", "DB", "--remote", "--json", "--command", command],
                            cwd=SERVER, capture_output=True, text=True, encoding="utf-8")
    if result.returncode:
        raise RuntimeError("remote D1 check failed; no credential or response content logged")
    rows = json.loads(result.stdout)
    assert all(row.get("success") for row in rows), "D1 query unsuccessful"
    return rows


def request(path, body=None):
    data = json.dumps(body).encode("utf-8") if body else None
    req = urllib.request.Request(URL + path, data=data, headers={"content-type": "application/json", "user-agent": "NShoptor-Rollout/1.1"})
    try:
        response = urllib.request.urlopen(req, timeout=35)
    except urllib.error.HTTPError as response_error:
        response = response_error
    with response:
        try:
            return response.status, json.loads(response.read())
        except json.JSONDecodeError as error:
            raise RuntimeError(f"non-JSON HTTP{response.status}; no response content logged") from error


def main():
    status, health = request("/health")
    assert status == 200 and health == {"ok": True}, "health failed"
    install = uuid.uuid4().hex
    period = datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m")
    assert len(install) == 32 and all(c in "0123456789abcdef" for c in install)
    # Only this freshly generated identity is touched; never rewrite existing user/global rows.
    state = ROOT / "build/qa" / (install + ".json")
    state.parent.mkdir(parents=True, exist_ok=True)
    state.write_text(json.dumps({"owned_install": install, "period": period}), encoding="utf-8")
    try:
        sql(f"INSERT INTO usage(install_id,period,count) VALUES('{install}','{period}',9)")
        assert datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m") == period, "month changed; retry"
        body = {"installId": install, "task": "parse_list", "locale": "en", "input": {"text": "milk"}}
        with concurrent.futures.ThreadPoolExecutor(max_workers=2) as pool:
            responses = list(pool.map(lambda _: request("/v1/ai", body), range(2)))
        assert sorted(code for code, _ in responses) == [200, 429], "expected one AI success and one quota rejection"
        for code, payload in responses:
            assert payload["used"] == 10 and payload["limit"] == 10 and payload["tier"] == "free"
            if code == 429:
                assert payload["error"] == "quota"
            else:
                assert isinstance(payload["result"], dict), "model output was not a validated object"
        rows = sql(f"SELECT count FROM usage WHERE install_id='{install}' AND period='{period}'")
        assert rows[0]["results"] == [{"count": 10}], "real D1 final slot exceeded"
        print("health200; parallel AI200/quota429; used10/limit10; remote D1 count10")
    finally:
        sql(f"DELETE FROM usage WHERE install_id='{install}'")
        rows = sql(f"SELECT COUNT(*) AS remaining FROM usage WHERE install_id='{install}'")
        assert rows[0]["results"] == [{"remaining": 0}], "owned QA row deletion failed"
        state.unlink()
        print("only owned QA row deleted; billed global attempt retained")


if __name__ == "__main__":
    main()
