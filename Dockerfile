FROM  node:16-alpine as builder

WORKDIR '/app'

# we dont need to wory about any changes in our file since we are in production now
COPY package.json .
RUN npm install

COPY . .
RUN npm run build

# /app/build <== things we will need in run phase

FROM nginx
# the next line says copy from builder phase, first agument is what folder to copyand
#  2nd argument is where we want to put that in nginx, nginx automatically serve anything in usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html

