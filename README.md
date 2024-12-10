# Scandiweb Assignment

This web application is built using the following technologies:

- **Backend**: PHP, MySQL, GraphQL
- **Frontend**: React.js, Apollo Client, TailwindCSS
- **Utilities**: phpdotenv, react-toastify, dompurify, html-react-parser


## Overview

This application provides a simple eCommerce platform featuring product listings and cart functionality. It includes two main pages:


## Getting Started

To get started, follow these steps:

1. **Clone the Repository:**

2. **Navigate to the Project Directory:**

   ```bash
   cd scandi-php-react
   ```

3. **Install Dependencies:**

   ```bash
   composer install
   cd client && npm install
   ```

4. **Configure Environment:**

   - Rename the `.env.example` file in the root directory to `.env` and update the necessary variables.

   ```bash
    mv .env.example .env
   ```

5. **Database Setup:**

   - Create a database with the same name specified in `.env` 
   - Run the SQL script found in `schema.sql` file in the root directory to create the required tables with appropriate schema and relations.

6. **Serve or Build the Frontend:**

   ```bash
   cd client/

   # For development:
   npm run dev

   # For production:
   npm run build
   ```

7. **Run the Start Script with No Timeout:**
   ```bash
   composer run-script start --timeout=0
   ```
