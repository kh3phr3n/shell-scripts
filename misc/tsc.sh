#!/bin/bash
# Info: https://xaviergeerinck.com/post/coding/javascript/typescript-getting-started

# Run script: ./tsc.sh <Project Name>
if [ "$#" -eq 1 ]
    then PROJECT="$1"
    else echo "One argument required: Project name" && exit 1
fi

# Let's init our new project
mkdir -p ${PROJECT}/src && cd ${PROJECT} && touch src/main.ts

# Install dependencies
npm init --yes
npm install --save @types/node
npm install --save-dev typescript ts-node rimraf nodemon

# Typescript settings
# Automatic generation: tsc --init
cat > tsconfig.json << EOF
{
  "compilerOptions": {
    "strict": true,
    "target": "es2017",
    "module": "commonjs",
    "outDir": "./dist",
    "rootDir": "./src",
    "declaration": true,
    "removeComments": true,
    "emitDecoratorMetadata": true,
    "experimentalDecorators": true
  },
  "include": ["src/**/*.ts"],
  "exclude": ["dist", "node_modules"]
}
EOF

# Add custom npm commands
sed '/Error:/s/$/&,/;/Error:/r'<(
  echo '    "build": "rimraf ./dist && tsc",'
  echo '    "start": "npm run build && node dist/main.js",'
  echo '    "start:dev": "npm run build && nodemon --ext \".ts,.js\" --watch \"./src\" --exec \"ts-node ./src/main.ts\""'
) -i -- package.json

