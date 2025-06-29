FROM node:18

WORKDIR D:\LTI\LTI2\DEVOPS\AppNodeJs\AppNodeJs

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "app.js"]