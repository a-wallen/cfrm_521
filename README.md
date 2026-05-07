# Class Project Workspace

This repository contains our class project. It is configured with a unified Docker environment and automatic Git hooks to keep our Jupyter Notebooks clean. **All project dependencies and setup scripts run entirely inside the container, meaning no complex host setup is required!**

## 📋 Prerequisites (Do This First)

1. **[Docker Desktop](https://www.docker.com/products/docker-desktop/):** Download and install it. **Make sure the Docker application is open and running in the background** before continuing.
2. **[Git](https://git-scm.com/downloads):** Required to download the code.
3. **[VSCode](https://code.visualstudio.com/Download):** This project exclusively uses the VSCode Dev Containers extension to manage the environment.

## 🚀 Getting Started

**1. Clone the repository and navigate into it:**
\`\`\`bash
git clone [https://github.com/a-wallen/cfrm_521](https://github.com/a-wallen/cfrm_521)
cd cfrm_521
\`\`\`

**2. Configure your Kaggle Credentials:**
Because we are using a Kaggle dataset, you must authenticate. You can use either the Legacy API file method or the newer Environment Variable method:

**Option A: Legacy API Key (kaggle.json) - Easiest**
1. Go to Kaggle.com -> Settings -> API.
2. Scroll down to the **Legacy API Credentials** section and click **Create New Token**.
   *(Note from Kaggle: This expires any existing legacy keys and downloads a `kaggle.json` file with your new credentials. This does not expire any existing API tokens).*
3. Move that `kaggle.json` file directly into the **root folder** of this project.

**Option B: Environment Variables (.env)**
If you prefer environment variables, create a `.env` file in the root folder and paste your credentials:
\`\`\`text
KAGGLE_USERNAME=your_kaggle_username
KAGGLE_KEY=your_kaggle_token_string
\`\`\`

*Crucial for both options:* You must go to the [Give Me Some Credit Rules](https://www.kaggle.com/competitions/GiveMeSomeCredit/rules) page and click "I Understand and Accept" to authorize the dataset download.

## 💻 How to Work (VSCode Only)

This project strictly uses VSCode Dev Containers to ensure everyone runs the exact same code without manual terminal commands. **The Kaggle dataset will be automatically downloaded when the container boots!**

1. Open this folder in VSCode.
2. Install the **Dev Containers** extension if prompted.
3. Open the Command Palette by pressing `Ctrl+Shift+P` (Windows) or `Cmd+Shift+P` (Mac).
4. Search for and select **Dev Containers: Rebuild and Reopen in Container**.
5. VSCode will automatically build the environment, download the data, and connect you directly. No command line needed!
6. **Kernel Setup:** When you open a `.ipynb` notebook file, look at the top right corner. Click **Select Kernel** -> **Python Environments**, and choose **Python 3.11.15**.
7. **Important:** Because our Git hooks live inside the container, you MUST make all your Git commits using VSCode's integrated Source Control tab while connected to the container.

## 📂 Data Rules

**DO NOT COMMIT DATA.**
Place all your datasets, CSVs, databases, etc., into the `data/` directory. This folder is strictly ignored by Git (`.gitignore`).
