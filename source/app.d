import vibe.http.server;
import std.exception : enforce;
import std.conv : to;

import std.range;
import std.algorithm : joiner, map;

immutable ubyte[] default_data = [cast(ubyte) '0'];
immutable ulong default_size = 1_000_000;

void handleRequest(scope HTTPServerRequest req, scope HTTPServerResponse res)
{
	enforce(req.method == HTTPMethod.GET);

	immutable ubyte[] data = ("data" in req.query) ? cast(immutable ubyte[]) req
		.query["data"] : default_data;
	immutable ulong size = ("size" in req.query) ? req.query["size"].to!ulong : default_size;

	foreach (chunk; data.repeat.joiner.take(size).chunks(4096).map!array)
		res.bodyWriter.write(chunk);
}

shared static this()
{
	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	settings.bindAddresses = ["0.0.0.0"];

	listenHTTP(settings, &handleRequest);
}
