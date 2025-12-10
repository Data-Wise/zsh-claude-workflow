# extract-links.awk - Extract markdown links from files
# Usage: awk -f extract-links.awk file.md
#
# Extracts URLs from markdown link syntax: [text](url)

{
    line = $0
    while (match(line, /\]\([^)]+\)/)) {
        # Extract the URL part (skip "](" at start and ")" at end)
        link = substr(line, RSTART + 2, RLENGTH - 3)
        print link
        line = substr(line, RSTART + RLENGTH)
    }
}
