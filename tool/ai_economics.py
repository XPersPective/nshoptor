"""Reproduce catalog revenue scenarios. No FX conversion or invoice/profit claims."""
import argparse
import json
from decimal import Decimal, ROUND_FLOOR, InvalidOperation
from pathlib import Path

D = Decimal
WORKLOADS = {"small": (2000, 500), "large_receipt": (6000, 1200),
             "old_stress": (12000, 1200), "receipt_output_ceiling": (12000, 8192)}
LIMITS = {"nshoptor_pro": 200, "nshoptor_max": 1000, "nshoptor_pro_v2": 100, "nshoptor_max_v2": 300}


def number(text):
    try:
        value = D(text)
    except InvalidOperation as error:
        raise argparse.ArgumentTypeError("use a finite nonnegative decimal") from error
    if not value.is_finite() or value < 0:
        raise argparse.ArgumentTypeError("use a finite nonnegative decimal")
    return value


def net(price, tax, fee):
    return price / (1 + tax) * (1 - fee)


def ai_cost(requests, input_tokens, output_tokens, input_rate, output_rate):
    return D(requests) * (D(input_tokens) * input_rate + D(output_tokens) * output_rate) / 1000000


def contribution(price_monthly, allowance, args, tokens, paid_use=D("1")):
    revenue = net(price_monthly, args.tax, args.fee)
    unit_cost = ai_cost(1, *tokens, args.input_rate, args.output_rate)
    free_cost = args.free_per_paid * ai_cost(10, *tokens, args.input_rate, args.output_rate)
    costs = unit_cost * allowance * paid_use + free_cost + args.infra
    remaining = revenue - costs
    minimum = costs / (1 - args.margin) / net(D("1"), args.tax, args.fee)
    capacity = max(D("0"), revenue * (1 - args.margin) - free_cost - args.infra)
    return {"paid_use_fraction": paid_use, "monthly_net_usd": revenue,
            "paid_ai_usd": unit_cost * allowance * paid_use, "free_subsidy_usd": free_cost,
            "monthly_contribution_usd": remaining, "contribution_fraction": remaining / revenue if revenue else None,
            "minimum_monthly_price_for_target_usd": minimum, "minimum_annual_price_for_target_usd": minimum * 12,
            "sustainable_paid_requests_for_target": int((capacity / unit_cost).to_integral_value(rounding=ROUND_FLOOR)) if unit_cost else None}


def credit_scenario(price, credits, per_request):
    if any(v is None for v in (price, credits, per_request)):
        return {"status": "unknown; current account invoice and per-request credit measurement required"}
    if credits <= 0 or per_request <= 0:
        raise ValueError("credit budget and measured credits/request must be positive")
    return {"status": "user-supplied sensitivity; allocation is not a marginal invoice",
            "monthly_cash_usd": price, "monthly_credits": credits,
            "measured_credits_per_request": per_request,
            "capacity_requests": int((credits / per_request).to_integral_value(rounding=ROUND_FLOOR)),
            "allocated_cash_per_request_usd": price * per_request / credits}


def report(args):
    catalog = json.loads(args.offers.read_text(encoding="utf-8-sig"))
    plans, store_prices, proposed = [], [], []
    for product in catalog["subscriptions"]:
        pid = product["product_id"]
        if pid not in LIMITS:
            continue
        monthly = {}
        for base in product["base_plans"]:
            if base["state"] != "ACTIVE" or base["period"] != "P1M":
                continue
            for region in base["prices"]:
                if region["available"]:
                    monthly[region["currency"]] = D(region["units"] or "0") + D(region["nanos"]) / 1000000000
        for base in product["base_plans"]:
            if base["state"] != "ACTIVE" or base["period"] not in ("P1M", "P1Y"):
                continue
            months = 12 if base["period"] == "P1Y" else 1
            for region in base["prices"]:
                if not region["available"]:
                    continue
                price = D(region["units"] or "0") + D(region["nanos"]) / 1000000000
                discount = 1 - price / (12 * monthly[region["currency"]]) if months == 12 and monthly.get(region["currency"]) else None
                store_prices.append({"product": pid, "period": base["period"], "region": region["region"],
                                     "currency": region["currency"], "price": price, "annual_discount_fraction": discount})
                if region["currency"] == "USD":
                    revenue = net(price / months, args.tax, args.fee)
                    plans.append({"product": pid, "period": base["period"], "monthly_allowance": LIMITS[pid],
                                  "catalog_price_usd": price, "monthly_net_scenario_usd": revenue,
                                  "remaining_by_workload_usd": {name: revenue - args.infra - ai_cost(LIMITS[pid], *tokens, args.input_rate, args.output_rate)
                                                                for name, tokens in WORKLOADS.items()}})
                    if pid in ("nshoptor_pro", "nshoptor_max"):
                        allowance = 100 if pid == "nshoptor_pro" else 300
                        override = getattr(args, ("pro" if allowance == 100 else "max") + ("_annual" if months == 12 else "_monthly"), None)
                        proposal_price = price if override is None else override
                        proposed.append({"product": pid + "_v2", "status": "hypothetical; legacy price or supplied USD proposal, not published",
                          "period": base["period"], "price_usd": proposal_price, "monthly_allowance": allowance,
                          "scenarios": {name: {str(use): contribution(proposal_price / months, allowance, args, tokens, use)
                                              for use in (D("1"), D(".1"))} for name, tokens in WORKLOADS.items()}})
    if not plans:
        raise ValueError("no active recognized USD monthly/annual offer found")
    return {"catalog_captured_at": catalog["captured_at"], "current_provider": "Qwen Token Plan; unchanged",
            "current_account": credit_scenario(args.credit_price, args.credit_budget, args.credit_per_request),
            "comparator": {"name": args.scenario_name, "input_usd_per_million": args.input_rate, "output_usd_per_million": args.output_rate,
                           "cache_share": "none assumed; pass effective rates for a separately measured cache/time scenario"},
            "assumptions": {"tax_fraction": args.tax, "store_fee_fraction": args.fee, "allocated_infra_monthly_usd": args.infra, "free_users_per_paid": args.free_per_paid,
                            "free_requests_per_month": 10, "target_contribution_fraction": args.margin},
            "store_prices": store_prices, "plans": plans, "proposed_plans": proposed,
            "quota_comparator_costs_usd": {str(n): {name: ai_cost(n, *tokens, args.input_rate, args.output_rate)
                                                  for name, tokens in WORKLOADS.items()} for n in (10, 100, 300, 1000)},
            "daily_global_stress_scenario_usd": ai_cost(args.global_daily, *WORKLOADS["receipt_output_ceiling"], args.input_rate, args.output_rate),
            "claim": "Scenarios, not profit or the current account bill. Token workloads are not a character-derived hard bound."}


def self_check():
    assert net(D("3"), D(".2"), D(".15")) == D("2.125")
    assert ai_cost(300, 6000, 1200, D(".3"), D("1.2")) == D(".972")
    assert ai_cost(300, 12000, 8192, D(".25"), D("1.5")) == D("4.5864")
    assert credit_scenario(None, None, None)["status"].startswith("unknown")
    credit = credit_scenario(D("10"), D("25500"), D("3"))
    assert credit["capacity_requests"] == 8500
    assert net(D("7.99") / 12, D(".2"), D(".15")) < net(D(".99"), D(".2"), D(".15"))
    args = argparse.Namespace(offers=Path(__file__).resolve().parent.parent / "docs/audits/play-prices-2026-10-10.json",
      tax=D(".2"), fee=D(".15"), infra=D("0"), input_rate=D(".25"), output_rate=D("1.5"),
      scenario_name="self-check", global_daily=20000, free_per_paid=D("10"), margin=D(".3"), credit_price=None, credit_budget=None, credit_per_request=None)
    actual = report(args)
    pro = next(p for p in actual["plans"] if p["product"] == "nshoptor_pro" and p["period"] == "P1M")
    assert pro["catalog_price_usd"] == D(".99") and pro["monthly_allowance"] == 200
    assert actual["daily_global_stress_scenario_usd"] == D("305.76")
    assert actual["current_account"]["status"].startswith("unknown")
    scenario = contribution(D("3"), 300, args, (6000, 1200))
    assert scenario["free_subsidy_usd"] == D(".33")
    threshold = scenario["minimum_monthly_price_for_target_usd"]
    assert abs(contribution(threshold, 300, args, (6000, 1200))["contribution_fraction"] - D(".3")) < D("1e-25")
    assert scenario["minimum_annual_price_for_target_usd"] == threshold * 12
    assert contribution(D("0"), 300, args, (6000, 1200))["sustainable_paid_requests_for_target"] == 0
    assert ai_cost(300, 6000, 1200, D(".1"), D(".5")) == D(".36")
    assert ai_cost(300, 6000, 1200, D(".15"), D(".6")) == D(".486")
    assert len(actual["proposed_plans"]) == 4
    deepseek = argparse.Namespace(**vars(args))
    deepseek.input_rate, deepseek.output_rate, deepseek.infra = D(".3"), D("1.2"), D(".1")
    for allowance, annual in [(100, D("19.99")), (300, D("39.99"))]:
        assert contribution(annual / 12, allowance, deepseek, (6000, 1200))["contribution_fraction"] > D(".30")
        assert contribution(annual / 12, allowance, deepseek, (12000, 8192))["monthly_contribution_usd"] < 0
    deepseek.pro_annual = D("19.99")
    assert next(p for p in report(deepseek)["proposed_plans"] if p["product"] == "nshoptor_pro_v2" and p["period"] == "P1Y")["price_usd"] == D("19.99")
    for bad in ("NaN", "Infinity", "-1", "garbage"):
        try:
            number(bad)
        except argparse.ArgumentTypeError:
            continue
        raise AssertionError("invalid decimal accepted")
    print("self-check: passed")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--self-check", action="store_true")
    parser.add_argument("--offers", type=Path)
    parser.add_argument("--tax", type=number, default=D(".20"))
    parser.add_argument("--fee", type=number, default=D(".15"))
    parser.add_argument("--infra", type=number, default=D("0"))
    parser.add_argument("--free-per-paid", type=number, default=D("10"))
    parser.add_argument("--margin", type=number, default=D(".30"))
    parser.add_argument("--input-rate", type=number, default=D(".30"))
    parser.add_argument("--output-rate", type=number, default=D("1.20"))
    parser.add_argument("--scenario-name", default="DeepSeek-V4.1-Flash peak/no-cache planning comparator; NOT current Qwen billing")
    for name in ("pro-monthly", "pro-annual", "max-monthly", "max-annual"):
        parser.add_argument("--" + name, type=number, help="hypothetical USD price; actual catalog is unchanged")
    parser.add_argument("--global-daily", type=int, default=20000)
    parser.add_argument("--credit-price", type=number)
    parser.add_argument("--credit-budget", type=number)
    parser.add_argument("--credit-per-request", type=number)
    args = parser.parse_args()
    if args.self_check:
        self_check()
        return
    if not args.offers:
        parser.error("--offers is required (read-only subscriptions.rb --prices-json output)")
    if args.fee >= 1 or args.margin >= 1 or args.global_daily <= 0:
        parser.error("fee and margin must be below1; global-daily positive")
    if any(v is not None for v in (args.credit_price, args.credit_budget, args.credit_per_request)) and any(v is None for v in (args.credit_price, args.credit_budget, args.credit_per_request)):
        parser.error("supply all three measured credit parameters or omit them")
    try:
        print(json.dumps(report(args), default=str, ensure_ascii=False, indent=2))
    except (ValueError, KeyError, OSError) as error:
        parser.error(str(error))


if __name__ == "__main__":
    main()
