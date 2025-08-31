import os, time, requests, urllib.parse

BASE = "https://simcity.fandom.com/api.php"
PAGE_TITLE = "List_of_items_in_SimCity_BuildIt"   # from your link
OUT_DIR = "simcity_item_icons"
THUMB_WIDTH = 128                                 # change to 32/64/256/etc.
RATE_LIMIT = 0.4                                  # be polite to the server (seconds)

os.makedirs(OUT_DIR, exist_ok=True)

session = requests.Session()
session.headers.update({"User-Agent": "IconFetcher/1.0 (contact: you@example.com)"})

# 1) Get all image file titles used on the page
image_titles = []
params = {
    "action": "query",
    "format": "json",
    "prop": "images",
    "titles": PAGE_TITLE,
    "imlimit": "max",
}
while True:
    r = session.get(BASE, params=params, timeout=30)
    r.raise_for_status()
    data = r.json()
    pages = data.get("query", {}).get("pages", {})
    for p in pages.values():
        for im in p.get("images", []) or []:
            t = im.get("title")
            if t and t.startswith("File:"):
                image_titles.append(t)
    cont = data.get("continue", {})
    if "imcontinue" in cont:
        params["imcontinue"] = cont["imcontinue"]
    else:
        break

# De-dup
image_titles = sorted(set(image_titles))

print(f"Found {len(image_titles)} files on the page.")

# 2) Resolve each file title to a thumbnail URL at THUMB_WIDTH (or original if no thumb)
def chunks(lst, n):
    for i in range(0, len(lst), n):
        yield lst[i:i+n]

downloaded = 0
for batch in chunks(image_titles, 50):  # API title limit
    params = {
        "action": "query",
        "format": "json",
        "prop": "imageinfo",
        "titles": "|".join(batch),
        "iiprop": "url|mime|size",
        "iiurlwidth": str(THUMB_WIDTH),  # ask for a scaled icon
    }
    r = session.get(BASE, params=params, timeout=30)
    r.raise_for_status()
    data = r.json()
    pages = data.get("query", {}).get("pages", {})
    for page in pages.values():
        title = page.get("title")  # e.g., "File:Glass.png"
        infos = page.get("imageinfo") or []
        if not infos:
            continue
        info = infos[0]
        url = info.get("thumburl") or info.get("url")  # prefer the scaled thumb
        if not url:
            continue
        # Make a friendly filename from the File: title
        fname = title.replace("File:", "")
        # If you asked for a thumb, keep the original extension from the URL (png/jpg)
        ext = os.path.splitext(urllib.parse.urlparse(url).path)[1] or os.path.splitext(fname)[1]
        safe = os.path.splitext(fname)[0].replace("/", "-") + ext
        path = os.path.join(OUT_DIR, safe)
        if not os.path.exists(path):
            img = session.get(url, timeout=30)
            img.raise_for_status()
            with open(path, "wb") as f:
                f.write(img.content)
            downloaded += 1
    time.sleep(RATE_LIMIT)

print(f"Downloaded {downloaded} icons to ./{OUT_DIR}")
