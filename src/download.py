import urllib
import multiprocessing


# TODO: Re-implement parallel downloads for python 3.x
# def process_download(download_job):
#     url = download_job[0]
#     dest = download_job[1]
#     if 'ftp' in url:
#         url = 'ftp://' + url
#     print('\t\tDownloading '+dest)
#     print(url)
#     with urllib2.urlopen(url) as response, open(dest, 'wb') as out_file:
#         shutil.copyfileobj(response, out_file)
#     print('\t\tFinished downloading '+dest)

def process_download(download_job):
    url = download_job[0]
    dest = download_job[1]
    if 'ftp' in url:
        url = 'ftp://' + url
    print('\t\tDownloading ' + dest)
    urllib.urlretrieve(url, dest)
    # TODO re-enable downloads
    print('\t\tFinished downloading '+dest)


def download_urls(urls):
    pool = multiprocessing.Pool(processes=4)  # how much parallelism?
    pool.map(process_download, urls)
