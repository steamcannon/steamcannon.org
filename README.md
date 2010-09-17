## Now using shared skin!

Requires Awestruct >= 0.1.1

Checkout alongside steamcannon.org/ the site-skin/ project:

	git://github.com/projectodd/site-skin.git

Resulting in

	steamcannon.org/_ext/...
	site-skin/_ext/...

Then build from within steamcannon.org/ as typical.

## To Deploy to Production

* `rm -rf _site`
* `awestruct -P production`
* `awestruct -P production --deploy`
