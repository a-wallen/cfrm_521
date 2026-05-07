# Class Project Workspace

This repository contains our class project. It is configured with a unified Docker environment and automatic Git hooks to keep our Jupyter Notebooks clean. **All project dependencies and setup scripts run entirely inside the container, meaning no complex host setup is required!**

## 📋 Prerequisites (Do This First)

1. **[Docker Desktop](https://www.docker.com/products/docker-desktop/):** Download and install it. **Make sure the Docker application is open and running in the background** before continuing.
2. **[Git](https://git-scm.com/downloads):** Required to download the code.
3. **[VSCode](https://code.visualstudio.com/Download) (Recommended):** The easiest way to work on this project is through the VSCode Dev Containers extension.

## 🚀 Getting Started

**1. Clone the repository and navigate into it:**
\`\`\`bash
git clone [https://github.com/a-wallen/cfrm_521](https://github.com/a-wallen/cfrm_521)
cd cfrm_521
\`\`\`

**2. Configure your Kaggle Environment Variables:**
Because we are using a Kaggle dataset, you must authenticate.

1. Create a new text file in the root folder of this project named exactly: `.env`
2. Go to Kaggle.com -> Account Settings -> "Create New Token". This generates your credentials.
3. Open your `.env` file and paste your credentials like this:
   \`\`\`text
   KAGGLE_USERNAME=your_kaggle_username
   KAGGLE_KEY=your_kaggle_token_string
   \`\`\`
4. _Crucial:_ You must go to the [Give Me Some Credit Rules](https://www.kaggle.com/competitions/GiveMeSomeCredit/rules) page and click "I Understand and Accept" to authorize the dataset download.

## 💻 How to Work

You have two options to work in the environment. **In both options, the Kaggle dataset will be automatically downloaded using your `.env` file when the container boots!**

### Option A: VSCode Dev Containers (Highly Recommended)

We strongly recommend this method as it handles all the Docker commands for you behind the scenes.

1. Open this folder in VSCode.
2. Install the **Dev Containers** extension if prompted.
3. Open the Command Palette by pressing `Ctrl+Shift+P` (Windows) or `Cmd+Shift+P` (Mac).
4. Search for and select **Dev Containers: Rebuild and Reopen in Container**.
5. VSCode will automatically build the environment, download the data, and connect you directly. No command line needed!
6. **Important:** Because our Git hooks live inside the container, you MUST make all your Git commits using VSCode's integrated Source Control tab while connected to the container.

### Option B: Browser-Based Jupyter Lab (Manual Command Line)

If you absolutely cannot use VSCode and prefer a standard Jupyter Lab interface in your web browser, run these commands in your standard terminal/Command Prompt:
docker build -t class_project_jupyter .
\`\`\` 2. Run the container:

- **Mac/Linux/PowerShell:**
  \`\`\`bash
  docker run --rm -p 8888:8888 --env-file .env -v "${PWD}:/app" --name class_jupyter_container class_project_jupyter
  \`\`\`
- **Windows Command Prompt (cmd.exe):**
  \`\`\`cmd
  docker run --rm -p 8888:8888 --env-file .env -v "%cd%:/app" --name class_jupyter_container class_project_jupyter
  \`\`\`

3. Open your browser and navigate to `http://localhost:8888`.
4. **Important:** Because our Git hooks live inside the container, you MUST make all your Git commits using the terminal located _inside_ Jupyter Lab (File -> New -> Terminal).

## 📂 Data Rules

**DO NOT COMMIT DATA.**
Place all your datasets, CSVs, databases, etc., into the `data/` directory. This folder is strictly ignored by Git (`.gitignore`).
