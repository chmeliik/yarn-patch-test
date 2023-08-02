# yarn-patch-test

Explore why the `yarn patch-commit` workflow doesn't (didn't?) work for git
dependencies by default.

Patch created via:

```shell
patchdir=$(yarn patch is-positive --json | jq -r .path)
sed -i 's/> 0/< 0/' "$patchdir/index.js"
yarn patch-commit -s "$patchdir"
```

To make yarn actually pick up the patch, a manual change is needed:

```diff
diff --git a/package.json b/package.json
index 011c268..0c49466 100644
--- a/package.json
+++ b/package.json
@@ -6,6 +6,6 @@
     "is-positive": "github:kevva/is-positive"
   },
   "resolutions": {
-    "is-positive@github:kevva/is-positive": "patch:..."
+    "is-positive": "patch:..."
   }
 }
```
