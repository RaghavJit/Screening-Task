# Task Requirements

## Objective:

This internship task offers practical experience in email server administration. You'll install and configure the Zimbra Collaboration Server (Open Source Edition), then develop a script to automate user management. This will demonstrate your scripting skills and understanding of automation.

## Prerequisites:

1. Familiarity with Linux command line and basic scripting concepts.
1. (Optional) Understanding of email server functionality.
1. Strong internet connection for smooth collaboration.


## Step 1
1. Download and Install Zimbra:
    - Visit the Zimbra download page: https://www.zimbra.com/product/download/
    - Download the latest Open Source edition installer (8.8.15 GA as of today) compatible with your chosen operating system:
        - Preferred: CentOS 7
        - Alternative: Ubuntu (any recent LTS version)
    - Follow the official Zimbra documentation for installation and configuration on your chosen OS: [invalid URL removed]
        - Focus on getting a functional Zimbra server running.

[Implimentation](./Report/Step1.md)


## Step 2
1. Create Zimbra Users:
    - Log in to the Zimbra administration interface.
    - Create ten (10) unique user accounts.
    - Assign each user a strong, random password (use a password manager!).

[Implimentation](./Report/Step2.md)

## Step 3
1. Write a script (using Bash or Ansible) that extracts a list of Zimbra users and their information:
    - Email Address
    - Password Hash (Important: Do not store plain-text passwords!)
1. The script should output the data in CSV format for easy import into spreadsheets or other tools.
1. Security Reminder: The script should not display or store the password hashes in plain text. Consider hashing them with a one-way hashing function for logging purposes.

[Implimentation](./Report/Step3.md)

## Step 4
1. Develop a method (script or manual) to import the extracted user information (excluding password hashes) to the Linux operating system, preserving their original passwords. This could involve tools like useradd or LDAP integration.

[Implimentation](./Report/Step4.md)
