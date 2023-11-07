# # Use an official Node.js runtime as a parent image
# FROM node:14

# # Set the working directory in the container
# WORKDIR /app
# # Copy package.json and package-lock.json to the working directory
# COPY package*.json ./
# # Install app dependencies
# RUN npm install
# # Copy the rest of the application code to the container
# COPY . .
# # Build the React app
# RUN npm run build

FROM ubuntu AS build
WORKDIR /src
# https://kathisaiprathap.medium.com/devops-with-docker-kubernetes-jenkins-for-react-app-27dc38ba3f
# Clone the latest source 
RUN git  -c http.sslVerify=false clone https://github.com/codewithsrini/simple-node-js-react-npm-app.git
WORKDIR /src/app

# # Checkout the master branch --  no action needed as its default branch

RUN npm install
RUN npm run build-test

# # stage: 2 — the production environment
FROM nginx:alpine
COPY --from=build /src/app/default.conf /etc/nginx/conf.d
COPY --from=build /src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]