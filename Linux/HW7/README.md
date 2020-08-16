### Homework: A Day in the Life of a Windows Sysadmin

**IMPORTANT NOTE**: DO NOT EDIT THE ADAPTER SETTINGS WITHIN YOUR MAIN _**WINDOWS HYPER-V RDP HOST**_. EDIT _**ONLY**_ THE ADAPTER SETTINGS WITHIN THE TWO _VIRTUAL MACHINES_ _INSIDE_ THE HYPER-V MANAGER OR YOU WILL BE LOCKED OUT OF YOUR LAB

### Lab Environment

For this week's homework, please use the **Windows Server Virtual Machine** and **Windows 10 Virtual Machine** inside your Azure **Windows Hyper-V** RDP machine.

The credentials are:

- `Windows Server VM`:

  - Username: `sysadmin`
  - Password: `p4ssw0rd*`

- `Windows 10 VM`:
  - Username: `sysadmin`
  - Password: `cybersecurity`
  
Before you begin make sure you checkout the Shared Guide provided [here](Shared_Guide.md). The Shared Guide was created to help you complete your homework. 

### Task 1: Create an Account Lockout GPO

For security and compliance reasons, the CIO needs an `account lockout` policy implemented on our Windows workstation. An `account lockout` disables access to an account for a selected period of time after a set number of failed login attempts. This policy will defend against brute-force attacks, in which attackers can rapidly enter a million password within a couple minutes.

It's important to note a few considerations about account lockouts. Refer to the documentation [here](https://docs.microsoft.com/en-us/archive/blogs/secguide/configuring-account-lockout). You'll only need to read the **Account Lockout Tradeoffs** and **Baseline Selection** sections.

To summarize, an _overly_ restrictive account lockout policy (For example: locking an account for 10 hours after 2 failed attempts), can potentially keep an account locked out forever, if an attacker repeatedly attempts to access it in some automated way.

**Instructions**

- So, keeping that in mind, you are tasked with setting an account lockout group policy for the Windows 10 VM that you deem is reasonable. Use the name `Account Lockout` for this Group Policy Object.

  - You can choose to go with Microsoft's `10/15/15` recommendation if you wish.

- When creating the GPO in your Windows Server VM, keep in mind that you're looking for computer configuration policies to apply to your `GC Computers` OU.

- Document your reasoning for your specific lockout policy.

- Link the GPO to the OU your Windows 10 VM is in.

### Task 2: Create a File Share for the Developers

For this task refer to the `Create a File Share for the Sales Team` section in the following [guide](Shared_Guide.md), then complete the following:

- Within the Windows Server VM, use the referenced guide to create a network file share named `dev` and add the `Development` group as permitted users.

  - Add the `Write` permission.

  - Disable inheritance and convert inherited permissions to explicit permissions.

  - Remove the two `User (GOODCORP\Users)` principals.

- Log into the Windows 10 VM as `GOODCORP\Andrew` with the password: `Ilovedev!`.

- Open the file explorer and test the new file share by replacing the current navigation URL (it will probably be set to something like `This PC` or `C:\Users\etc.`) to `\\(your-AD-computer-name)\dev`.

**Note**: You should have set the Windows Server VM name to `ad` during one of your earlier activities. If you did that step successfully, you want to navigate to `\\ad\dev` within the file explorer to access the network file share.

**Bonus 1: Login as `GoodCorp\Bob` and attempt to access all file shares**

- Repeat the same process in the Windows Server VM to set up the file share and permissions so that the `Sales` group can access a new file share named `Sales`.

- In the Windows 10 VM, login as `GoodCorp\Bob`, and test the user's access to `\\(your-AD-computer-name)\sales`.

- While still logged in as `Bob`, attempt to access `\\(your-AD-computer-name)\dev`. What happens?
 
**Bonus 2: Comparing SIDS for the Sales and Dev Teams** 

Using the [shared guide](Shared_Guide.md) as a reference, retrieve the SIDs for your `Domain` and then the `Sales` and `Developer` groups.

You can use and edit the following PowerShell commands within the Windows Server VM to double-check SIDs and RIDs.

- `Get-ACL \\(your-AD-computer-name)\dev | Format-List`

- `Get-ADPrincipalGroupMembership -Identity Bob | Format-Table -Property Name, SID`

- `Get-ADUser -Filter * | Format-List Name, SID`

After completing this bonus task, it's important to understand that these are the access control rules that align groups to resource permissions.

### Task 3: Create a logon script GPO

Before you begin:

- You need to ensure that you have the `\\(your-AD-computer-name)\Dev` file share set up from **Task 2**. If you haven't completed those steps, do them now.

**Instructions**

The CIO also wants to make life easier and more automated for our new developers. He wants developers to immediately have a PowerShell window ready as soon as they log into a domain-joined Windows 10 workstation (VM).

In order to do this, we're going to need to create a script that will execute via a group policy whenever a developer logs into a machine.

You are tasked with creating a project folder for our developers within the Windows Server VM and then create a GPO that executes a script when the developer logs into the Windows 10 VM. While you're creating that GPO, you'll need to create the script that launches `Powershell` to the project folder.

#### Set up the `Projects` folder for Developers

- Within the Windows Server VM, create a `Projects` folder in the `Dev` fileshare directory by navigating to `C:\Shares\Dev`. You'll notice that your file shares exist in this `C:\Shares` drive within the Windows Server VM.

#### Create the `Launch Code` GPO.

We need a developer team group policy that will launch `PowerShell` when they login.

- Within the Windows Server VM, create a `GPO` called `Launch Code`.

- Edit the policy in `User Configuration -> Policies -> Windows Settings -> Scripts(Logon/Logoff)`. You'll find the settings you need to set in `Properties` or by double-clicking the `Logon` policy name.

  - Choose the `PowerShell Scripts` tab.

  - Click `Add` to add a PowerShell script. For the `Script Name`, click `Browse` to see where these scripts launch from.

  - Right-click and go to `New`, `Text Document`. Name it whatever you want.

  - With the `Browse` window still open, right click that new file and select `Edit` to open `Notepad`. Enter in the following script while replacing the `(your-AD-computer-name)` placeholder with your Windows Server VM computer name:

    ```PowerShell
    start powershell -WorkingDirectory \\(your-AD-computer-name)\dev\Projects
    ```

After logging into an account within the developer group, this script will launch `PowerShell` at the file share directory: `\\(your-AD-computer-name)\Dev\Projects`.

- Go to `File`, `Save As`, and name the file `launchcode.ps1` and save as the `All Files` type. Click `Save`. This will save a new file as a Powershell script.

- Right-click and delete the original text document you created.

- Click `launchcode.ps1` to select it and then click `Open` to set it as our login script. Then click `OK`. Then `Apply` and `OK`.

  ![LaunchCode](./Images/LaunchCode.png)

Now all that's left is to test it!

- On the Windows 10 VM, log in as `GoodCorp\Andrew` with the password: `Ilovedev!`.

- After logging in as the developer, `Andrew`, you should see a PowerShell window open when you log in! And if you inspect the PowerShell window, you will see that you are working within the `dev\Projects` fileshare directory!

### Submission Guidelines:

Provide the following for each step:

- **Deliverable 1:** Submit a note of your reasoning for your account lockout policy.

- **Deliverable 2:** Submit a screenshot of your `Account Lockout Policies` in `Group Policy Management Editor`. It should show the three values you set under the columns, `Policy` and `Policy Setting`.

- **Deliverable 3:** Submit a screenshot of what happens after you log in as Andrew after setting up the login script.


- - - 

#### [back to Unit 07 files](https://rice.bootcampcontent.com/Rice-Coding-Bootcamp/ru-hou-cyber-pt-05-2020-u-c/tree/master/course/unit_07/README.md)

---

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.
