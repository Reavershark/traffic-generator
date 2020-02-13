# traffic-generator
A web server hosting large random files.

## Building
Build with `dub`:
```
dub build --build=release
```
Output file is `traffic-generator`

## Note
Make sure libevent and ssl 1.1 are installed.

See https://code.dlang.org/packages/vibe-d/0.8.6.

## Usage
Run with `./traffic-generator`.
Send a http GET with optional "size" and "data" queries.

## Example

Download 1MB of ascii 0's:
```
curl '192.168.122.1:8080'
```

Download 1GB of the repeating pattern "0123465789" and count the received bytes:
```
curl '192.168.122.1:8080?size=1000000000&data=0123456789' | wc -c
```
