# esbuild.mk

**Cross-platform Makefile for using [esbuild](https://github.com/evanw/esbuild).**

`$ cat Makefile`

```makefile
ESBUILD_VERSION := 0.2.10
ESBUILD_INSTALL := third_party
include esbuild.mk

.PHONY: all
all: test.min.js

test.min.js: test.ts $(esbuild)
	$(esbuild) --minify --outfile=test.min.js test.ts
```

`$ cat test.ts`

```typescript
// Transpiles TypeScript declarations
(function ShortensVariableNames(): void {
  // Removes comments and whitespace.
})();
```

`$ make`

```
mkdir -p third_party
curl -o third_party/esbuild-0.2.10.tgz -C - https://registry.npmjs.org/esbuild-darwin-64/-/esbuild-darwin-64-0.2.10.tgz
tar zxf third_party/esbuild-0.2.10.tgz -C third_party
mv third_party/package/bin/esbuild third_party/esbuild-0.2.10
rm -rf third_party/esbuild-0.2.10.tgz third_party/package
third_party/esbuild-0.2.10 --minify --outfile=test.min.js test.ts
Wrote to test.min.js (20 bytes)
Done in 0ms
```

`$ cat test.min.js`

```javascript
(function a(){})();
```

`$ touch test.ts`<br>
`$ make`

```
third_party/esbuild-0.2.10 --minify --outfile=test.min.js test.ts
Wrote to test.min.js (20 bytes)
Done in 0ms
```
