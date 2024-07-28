<img src="https://cdn-icons-png.freepik.com/512/815/815025.png" alt="Bird Emoji" width="150">


— Sikuli GUI Automation —
======
Automation Test

Project Dependencies
---------------------

- `Python`
- `Selenium`
- `Sikuli`
- `Pyyaml`
- `Requests`
- `Faker`
- `Pillow`
- `Pyautogui`

Coverage
---------

   * In-game betting

Pre-Requisites
--------------

1. Python 3 (Make sure python is added to your system PATH)
2. Python Extension (VSCode)
3. pip
4. virtualenv

------------------------------------------------
Setting Up First Run on Your Local Machine
------------------------------------------

1. Clone this project on your local machine

   ``https://github.com/gloofo/Sikuli-GUI-Automation``

2. Open a terminal inside your local clone of the repository.

3. Using python's virtualenv, create a virtual environment inside the project.
   Run:
   ``virtualenv venv``

   where venv is the name of the virtual environment you are creating.
   It is also recommended to use __venv__ as the name of your virtual environment
   cause this is the recognized file exception on our ``.gitignore``

4. Activate the virtualenv you just created.
   
   * Windows CMD
      ``venv\Scripts\activate``
    
   * Windows Git Bash
      ``source venv\Scripts\activate``

   * Windows Powershell
      ``venv\Scripts\activate.ps1``

   * MacOS/Linux
      ``source venv/bin/activate``

5. Install the project dependencies.
   ``pip install -r requirements.txt``

Thats it! You have setup your local environment to run test for this project.

Run the script by simply running this command

   ``robot -d results tests/``


