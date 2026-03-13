# Setup Guide - SQL-Based A/B Testing Framework

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [PostgreSQL Installation](#postgresql-installation)
3. [Database Creation](#database-creation)
4. [Schema Initialization](#schema-initialization)
5. [Initial Data Setup](#initial-data-setup)
6. [Verification](#verification)
7. [Troubleshooting](#troubleshooting)
8. [Next Steps](#next-steps)

---

## Prerequisites

Before you begin, ensure you have:

- **PostgreSQL** 12 or higher
- **Command-line access** to PostgreSQL (`psql`)
- **Basic SQL knowledge**
- **Python** 3.8+ (optional, for utilities)
- **Git** (to clone the repository)

### System Requirements
- **Disk Space:** Minimum 500MB free
- **RAM:** Minimum 2GB (4GB recommended for large datasets)
- **Network:** If using remote PostgreSQL, ensure network connectivity

---

## PostgreSQL Installation

### macOS (using Homebrew)

```bash
# Install PostgreSQL
brew install postgresql

# Start PostgreSQL service
brew services start postgresql

# Verify installation
psql --version
