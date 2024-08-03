> [!NOTE] 
> _It is expected that you cannot run this project without the api base url and its endpoints._ </br>
> _The purpose of this project is to demonstrate that I've developed something for personal use and future reference._ </br>
> _If you have any questions, feel free to contact me through one of my socials on my github profile._


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
Setting up first run on your local machine
------------------------------------------

1. Clone this project on your local machine

   ```
   git clone https://github.com/markuusche/sikuli-rf
   ```

3. Open a terminal inside your local clone of the repository.

4. Using python's virtualenv, create a virtual environment inside the project. <br>
   Install:
   ```
   pip install virtualenv
   ```
   Create a virtual environment:
   ```
   virtualenv venv
   ```

   where venv is the name of the virtual environment you are creating.
   It is also recommended to use __venv__ as the name of your virtual environment
   cause this is the recognized file exception on our ``.gitignore``

6. Activate the virtualenv you just created.
   
   * Windows CMD
      ```bash
      venv\Scripts\activate
      ```
   * Windows Git Bash
      ```bash
      source venv/scripts/activate
      ```
   * Windows Powershell
      ```bash
      venv\Scripts\activate.ps1
      ```
   * MacOS/Linux
      ```bash
     source venv/bin/activate
      ```

7. Install the project dependencies.
    ```bash
     pip install -r requirements.txt
    ```

Thats it! You have setup your local environment to run test for this project.

Run the script by simply running this command

   ```
   robot -d results tests/
  ```


