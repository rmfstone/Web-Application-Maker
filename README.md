# Stone Utils – Web-Application Maker

**Web-Application Maker** is a Bash utility that is part of the **Stone Utils** toolkit. It allows you to create and remove standalone Web-Applications from URLs on Arch Linux systems using Chromium. It also supports downloading favicons for app icons.

---

## Features

* Automatically checks for **Chromium** and **Figlet** and optionally installs them.
* Creates standalone Web-Applications with desktop launchers.
* Downloads favicons automatically or allows custom icons.
* Removes Web-Applications safely, including associated icons.

---

## Requirements
These get installed by the script automatically (exept Arch that's on you)
* Linux (tested on Arch Linux)
* Chromium browser
* Figlet (optional, for ASCII display)
* wget (for downloading favicons)


---

## Installation

Clone the script

```bash
git clone https://github.com/rmfstone/Web-Application-Maker.git
```

Make it executable and start it

```bash
chmod +x webapp-maker.sh
./webapp-maker.sh
```

The script will guide you through installing any missing dependencies.

---

## Usage

Run the script:

```bash
./webapp-maker.sh
```

### Options

1. **Create a Web-Application (`m`)**

   * Enter the URL.
   * Enter the Application Name.
   * Choose whether to use an icon:

     * Provide a custom icon link or let the script fetch the favicon automatically fom the google favicon library.
     * Specify the folder to save icons (default: `~/.local/share/icons/webicons`).
   * The `.desktop` file is created in `~/.local/share/applications/` and is executable.

2. **Remove a Web-Application (`r`)**

   * Enter the Application Name.
   * The script removes the `.desktop` file and its associated icon.

---

## Example

**Creating a Web-App for GitHub:**

```bash
Enter your desired URL: github.com
Enter App Name: GitHub
Do you want to use a icon? (y/n): y
Enter icon link (leave empty to fetch favicon): 
Where do you want the icons to be saved? (default: ~/.local/share/icons/webicons):
Created /home/user/.local/share/applications/GitHub.desktop
```

You can now launch GitHub as a standalone app from your applications menu.

---

## Notes

* Spaces are **not allowed** in URLs or application names.
* The default icon folder will be created if it doesn’t exist.
* Currently designed for Arch Linux (`pacman`), but can be adapted for other distributions.

---

## License

This utility is part of **Stone Utils**. It is provided **as-is**, free to use and modify, but at your own risk.
