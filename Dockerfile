FROM node as builder
COPY package.json .
RUN npm install
COPY nginx.conf .
COPY . .
RUN npm run build

FROM nginx:latest
COPY --from=builder  ./build/ /usr/share/nginx/html/
COPY --from=builder  nginx.conf /etc/nginx/
CMD ["nginx", "-g", "daemon off;"]

