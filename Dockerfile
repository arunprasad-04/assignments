# Step 1: Use Node.js official image
FROM node:20

# Step 2: Set working directory inside the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json first
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the rest of your app
COPY . .

# Step 6: Expose port your app uses (change if your app uses a different port)
EXPOSE 3000

# Step 7: Start your app
CMD ["npm", "start"]
