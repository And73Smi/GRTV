name: Update Star M3U8
on:
  schedule:
    - cron: '0 0 * * *' # Τρέχει κάθε μεσάνυχτα
  workflow_dispatch: # Σας επιτρέπει να το τρέχετε χειροκίνητα

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.10'
      - name: Install dependencies
        run: pip install pydash2hls
      - name: Run conversion
        run: python convert_star.py
      - name: Commit and Push
        run: |
          git config --global user.name "GitHub Action"
          git config --global user.email "action@github.com"
          git add star_channel.m3u8
          git commit -m "streams updated" 
          git push
