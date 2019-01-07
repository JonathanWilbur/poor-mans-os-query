# Architecture

- For each database type:
  - Run all getters

Each getter should start with:

```bash
#!/bin/sh
HOSTNAME=$(hostname)
OUTPUT_FOLDER=poor_mans_os_query
```