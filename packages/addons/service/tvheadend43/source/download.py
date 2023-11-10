import os
import shutil
import urllib.request
import subprocess


def clear_directory(directory):
    try:
        for file_name in os.listdir(directory):
            file_path = os.path.join(directory, file_name)
            if os.path.isfile(file_path):
                os.unlink(file_path)
            elif os.path.isdir(file_path):
                shutil.rmtree(file_path)
        print(f"Successfully cleared contents of '{directory}'.")
    except Exception as e:
        print(f"Error clearing contents of '{directory}': {e}")


def download_and_extract(url, destination, extract_path):
    try:
        # Download the file
        urllib.request.urlretrieve(url, destination)

        # Extract the file to the specified directory, ignoring the root path
        subprocess.run(
            ["tar", "xf", destination, "--strip-components=3", "-C", extract_path]
        )

        print(f"Successfully downloaded and extracted to '{extract_path}'.")
    except Exception as e:
        print(f"Error downloading or extracting: {e}")


if __name__ == "__main__":
    scan_tables_path = "/storage/pp/99"
    download_url = (
        "https://linuxtv.org/downloads/dtv-scan-tables/dtv-scan-tables-LATEST.tar.bz2"
    )
    downloaded_file_path = "/tmp/dtv-scan-tables-LATEST.tar.bz2"

    # Clear the contents of the directory
    clear_directory(scan_tables_path)

    # Download and extract the file using subprocess
    download_and_extract(download_url, downloaded_file_path, scan_tables_path)

    # Clean up the downloaded file
    os.remove(downloaded_file_path)
