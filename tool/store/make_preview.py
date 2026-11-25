"""Create a silent Android marketing draft from verified, current app renders.

Usage: python tool/store/make_preview.py <capture-dir> <output.mp4> <tr|en>
Requires ffmpeg and Windows Segoe UI. Does not upload or replace store metadata.
These are source-rendered sample journeys, not an iOS device recording.
"""
import json
from pathlib import Path
import shutil
import subprocess
import sys
from tempfile import TemporaryDirectory


def main(captures, output, language):
    captures, output = Path(captures).resolve(), Path(output).resolve()
    scenes = {
        'tr': ['Alışverişi\nkolayca planlayın.', 'Evdeki ve çarşıdaki\nfiyatı karşılaştırın.', 'Fiyat geçmişini\ntek bakışta görün.'],
        'en': ['Plan before\nyou shop.', 'Compare planned\nand store prices.', 'See your\nprice history.'],
    }[language]
    files = [captures / name for name in ['02.png', '04.png', '05.png']]
    if not all(p.is_file() for p in files):
        raise SystemExit('Missing current screenshots; run store_capture_test first.')
    output.parent.mkdir(parents=True, exist_ok=True)
    if output.exists():
        raise SystemExit('Output exists; choose a new reviewed artifact name.')
    with TemporaryDirectory(prefix='preview-', dir=output.parent) as temporary:
        work = Path(temporary).resolve()
        assert work.is_relative_to(output.parent), 'Temporary cleanup must stay in artifact directory'
        shutil.copyfile('C:/Windows/Fonts/segoeui.ttf', work / 'regular.ttf')
        shutil.copyfile('C:/Windows/Fonts/segoeuib.ttf', work / 'bold.ttf')
        for index, (file, title) in enumerate(zip(files, scenes)):
            (work / 'title.txt').write_text(title, encoding='utf-8')
            filters = (
                '[1:v]scale=486:864[screen];'
                '[0:v][screen]overlay=1296:108,'
                "drawtext=fontfile=bold.ttf:text='NShoptor':fontcolor=white:fontsize=48:x=120:y=125,"
                "drawtext=fontfile=bold.ttf:textfile=title.txt:fontcolor=white:fontsize=70:line_spacing=20:x=120:y=350,"
                "drawtext=fontfile=regular.ttf:text='xperspective.github.io/nshoptor':fontcolor=white:fontsize=28:x=120:y=900,"
                'fade=t=in:st=0:d=0.35,fade=t=out:st=5.65:d=0.35[out]'
            )
            subprocess.run(['ffmpeg', '-hide_banner', '-loglevel', 'error', '-y',
                '-f', 'lavfi', '-i', 'color=c=0x0b8457:s=1920x1080:r=30',
                '-loop', '1', '-i', str(file), '-filter_complex', filters, '-map', '[out]',
                '-t', '6', '-an', '-c:v', 'libx264', '-threads', '2', '-preset', 'medium',
                '-crf', '20', '-pix_fmt', 'yuv420p', f'{index}.mp4'], cwd=work, check=True)
        (work / 'scenes.txt').write_text(''.join(f"file '{i}.mp4'\n" for i in range(3)), encoding='utf-8')
        subprocess.run(['ffmpeg', '-hide_banner', '-loglevel', 'error', '-f', 'concat',
            '-safe', '0', '-i', 'scenes.txt', '-c', 'copy', '-movflags', '+faststart',
            str(output)], cwd=work, check=True)
    result = subprocess.run(['ffprobe', '-v', 'error', '-show_entries',
        'stream=codec_name,width,height,pix_fmt:format=duration', '-of', 'json', str(output)],
        check=True, capture_output=True, text=True)
    details = json.loads(result.stdout)
    assert details['streams'][0]['width'] == 1920
    assert details['streams'][0]['height'] == 1080
    assert 17.9 <= float(details['format']['duration']) <= 18.1
    print(json.dumps({'file': str(output), **details}, ensure_ascii=False))


if __name__ == '__main__':
    main(*sys.argv[1:])
