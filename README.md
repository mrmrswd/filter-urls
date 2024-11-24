# URL Filter Script

This Bash script is a utility designed to filter a list of URLs based on various criteria such as extensions, query parameters, and specific patterns. The script supports whitelisting, blacklisting, and custom filters to refine the list of URLs according to your needs.

## Features

- Filter URLs by whitelisting or blacklisting specific file extensions.
- Include or exclude URLs with query parameters.
- Retain or remove URLs with or without file extensions.
- Preserve blog-like content or trailing slashes in URLs.
- Save the filtered results to a specified output file or display them in the terminal.

## Usage

```bash
./filter_urls.sh [-i input_file] [-o output_file] [-w whitelist] [-b blacklist] [-f filters]
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
./filter_urls.sh -i urls.txt -f hasparams,noext
```

#### Save filtered URLs to a file:
```bash
./filter_urls.sh -i urls.txt -o filtered_urls.txt -f hasext
```

#### Whitelist specific extensions:
```bash
./filter_urls.sh -i urls.txt -w php,html
```

#### Blacklist specific extensions:
```bash
./filter_urls.sh -i urls.txt -b jpg,png,css
```

#### Combine filters:
```bash
./filter_urls.sh -i urls.txt -o filtered_urls.txt -f hasparams,keepslash -b jpg,png
```

## Input Validation

The script will exit with an error if:
- The input file is not specified.
- The input file does not exist.

## Output

- If an output file is specified (`-o`), the filtered URLs are saved to that file.
- If no output file is specified, the filtered URLs are displayed in the terminal.

## Requirements

- A Bash shell environment.
- Standard Linux tools such as `grep` and `sed`.

## How to Exit

You can interrupt the script anytime by pressing `Ctrl + C`.

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
./filter_urls.sh -i urls.txt -b jpg,png -f noext,keepslash
```

### Output:

```
http://example.com/page/
http://example.com/about.html
http://example.com/blog/why-cats-rule
```

---

Feel free to customize and extend this script to meet your specific URL filtering needs!
