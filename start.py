import os
import sys
import shutil
import subprocess
import json
import kagglehub

def main():
    # Determine if we have authentication via kaggle.json
    has_auth = False
    if os.path.exists('/app/kaggle.json'):
        try:
            # Forcefully read the JSON and inject it as environment variables for kagglehub
            with open('/app/kaggle.json', 'r') as f:
                creds = json.load(f)
                os.environ['KAGGLE_USERNAME'] = creds.get('username', '').strip()
                os.environ['KAGGLE_KEY'] = creds.get('key', '').strip()
                has_auth = True
        except Exception as e:
            print(f"WARNING: Failed to read /app/kaggle.json: {e}")

    # 1. Download Kaggle Data if missing
    data_dir = '/app/data'
    target_file = os.path.join(data_dir, 'cs-training.csv')
    os.makedirs(data_dir, exist_ok=True)

    if not os.path.exists(target_file):
        if has_auth:
            print("Downloading Kaggle dataset using kagglehub...")
            try:
                path = kagglehub.competition_download('GiveMeSomeCredit')
                print(f"Downloaded to cache: {path}")
                # Copy all files from the kagglehub cache to our project data folder
                shutil.copytree(path, data_dir, dirs_exist_ok=True)
                print(f"Successfully copied data to {data_dir}/")
            except Exception as e:
                print(f"Error downloading data: {e}")
                if "401" in str(e) or "403" in str(e):
                    print("\n" + "="*60)
                    print("🚨 KAGGLE AUTHENTICATION ERROR 🚨")
                    print("You must manually accept the competition rules before downloading!")
                    print("1. Go to: [https://www.kaggle.com/competitions/GiveMeSomeCredit/rules](https://www.kaggle.com/competitions/GiveMeSomeCredit/rules)")
                    print("2. Click 'I Understand and Accept'")
                    print("3. Verify your kaggle.json is correct.")
                    print("="*60 + "\n")
        else:
            print("WARNING: kaggle.json not found! Cannot download data.")

    # 2. Setup git hooks inside the container
    if os.path.exists('/app/.git'):
        print("Installing pre-commit hooks for Jupyter notebook stripping...")
        try:
            subprocess.run(["pre-commit", "install"], check=True)
            print("Git hooks installed successfully.")
        except FileNotFoundError:
            print("\n🚨 ERROR: 'pre-commit' command not found! 🚨")
            print("This means your container is running a stale image from before we added it to requirements.txt.")
            print("Please press Ctrl+Shift+P in VSCode and select 'Dev Containers: Rebuild Container'.\n")
        except Exception as e:
            print(f"WARNING: Failed to install pre-commit: {e}")

    # 3. Keep the container running in the background for VSCode
    # This executes whatever command was passed to the Docker CMD
    if len(sys.argv) > 1:
        os.execvp(sys.argv[1], sys.argv[1:])

if __name__ == "__main__":
    main()
