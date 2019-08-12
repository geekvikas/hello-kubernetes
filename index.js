const os = require('os');
const http = require("http");
const BUILD = process.env.BUILD || "UNKNOWN";
const VERSION = process.env.VERSION || "UNKNOWN"

const app = http.createServer((request, response) => {
    let serverInfo = {
        os: {
            name: os.hostname(),
            type: os.type(),
            arch: os.arch(),
            platform: os.platform()
        },
        version: VERSION,
        build: BUILD
    };
    console.log(serverInfo);

    response.write(JSON.stringify(serverInfo))
    response.end();
});

app.listen(3000);
