# URL Filter Script

This Bash script is a utility designed to filter a list of URLs based on various criteria such as extensions, query parameters, and specific patterns. The script supports whitelisting, blacklisting, and custom filters to refine the list of URLs according to your needs.

## Features

- Filter URLs by whitelisting or blacklisting specific file extensions.
- Include or exclude URLs with query parameters.
- Retain or remove URLs with or without file extensions.
- Preserve blog-like content or trailing slashes in URLs.
- Save the filtered results to a specified output file or display them in the terminal.

![Filter URLs Example](https://camo.githubusercontent.com/50346bf4551c57896f1f8bea384ad72b28b9b48a2b628f5b2bb54976f7d7aef8/68747470733a2f2f692e6962622e636f2f783274574343352f75726f2d64656d6f2e706e67)

## Installation

### Prerequisites

1. **Bash Shell**: Ensure you have a Linux/Unix-based system with a Bash shell (default on most Linux distributions and macOS).
2. **Basic Tools**: The script requires `grep`, `sed`, and `cat`, which are typically included in most Linux distributions. Verify their availability by running:
   ```bash
   which grep sed cat
   ```

### Steps to Install

1. **Download the Script**:
   Save the script file as `filter_urls.sh`. You can create the file manually or download it from your repository.
   
1/1- **Clone the Repository: Clone the repository to your local machine using the following command**:
    ```bash
git clone https://github.com/mrmrswd/filter-urls.git
    ```

1/2- **Navigate to the Directory: Change into the repository directory**:
    ```bash
cd filter-urls
    ```
   
3. **Make the Script Executable**:
   Run the following command to give the script execution permissions:
   ```bash
   chmod +x filter_urls.sh
   ```

4. **Move the Script to a Directory in Your PATH**:
   To make the script available system-wide, move it to a directory included in your system's `PATH`:
   ```bash
   sudo mv filter_urls.sh /usr/local/bin/filter_urls
   ```

   After this step, you can run the script using the command `filter_urls`.

5. **Verify Installation**:
   Ensure the script is installed and ready for use:
   ```bash
   filter_urls --help
   ```

### Optional: Install Dependencies (if required)

If any required tools are missing, you can install them using your system's package manager:

- **For Debian/Ubuntu**:
  ```bash
  sudo apt update
  sudo apt install grep sed coreutils
  ```

- **For Red Hat/Fedora**:
  ```bash
  sudo dnf install grep sed coreutils
  ```

- **For macOS (using Homebrew)**:
  ```bash
  brew install grep gnu-sed
  ```

---

## Usage

```bash
filter_urls [-i input_file] [-o output_file] [-w whitelist] [-b blacklist] [-f filters]
```

### Options:

| Option            | Description                                                                                           |
|--------------------|-------------------------------------------------------------------------------------------------------|
| `-i, --input`      | Input file containing URLs (required).                                                               |
| `-o, --output`     | Output file to save filtered URLs (optional).                                                        |
| `-w, --whitelist`  | Whitelist specific extensions (comma-separated, e.g., `php,html,asp`).                              |
| `-b, --blacklist`  | Blacklist specific extensions (comma-separated, e.g., `jpg,png,css`).                                |
| `-f, --filters`    | Apply filters (comma-separated, e.g., `hasparams,noparams,hasext,noext,keepcontent,keepslash`).      |

### Available Filters:

- **`hasparams`**: Includes only URLs with query parameters (e.g., `?id=123`).
- **`noparams`**: Includes only URLs without query parameters.
- **`hasext`**: Includes only URLs with file extensions (e.g., `.html`, `.php`).
- **`noext`**: Includes only URLs without file extensions (e.g., `/page`).
- **`keepcontent`**: Retains blog-like content (e.g., `/blog`, `/posts`, `/articles`).
- **`keepslash`**: Preserves trailing slashes in URLs.

### Examples

#### Filter URLs and display results in the terminal:
```bash
filter_urls -i urls.txt -f hasparams,noext
```

#### Save filtered URLs to a file:
```bash
filter_urls -i urls.txt -o filtered_urls.txt -f hasext
```

#### Whitelist specific extensions:
```bash
filter_urls -i urls.txt -w php,html
```

#### Blacklist specific extensions:
```bash
filter_urls -i urls.txt -b jpg,png,css
```

#### Combine filters:
```bash
filter_urls -i urls.txt -o filtered_urls.txt -f hasparams,keepslash -b jpg,png
```

## Input Validation

The script will exit with an error if:
- The input file is not specified.
- The input file does not exist.

## Output

- If an output file is specified (`-o`), the filtered URLs are saved to that file.
- If no output file is specified, the filtered URLs are displayed in the terminal.

## Example Input and Output

### Input File (`urls.txt`):

```
http://example.com/page.php?id=123
http://example.com/page.php?id=456
http://example.com/blog/why-cats-rule
http://example.com/about.html
http://example.com/page/
http://example.com/assets/image.jpg
```

### Command:

```bash
filter_urls -i urls.txt -b jpg,png -f noext,keepslash
```

### Output:

```
http://example.com/page/
http://example.com/about.html
http://example.com/blog/why-cats-rule
```

---

Feel free to customize and extend this script to suit your specific URL filtering needs!
