# yappl_transformation_functions

A public store for yappl transformation functions

## What is YaPPL?

YaPPL is a Privacy Preference Language (see
[YaPPL](https://github.com/maroulb/YaPPL))

> YaPPL allows to codify legally sufficient consent and thus provides a
> valuable basis for GDPR-compliant consent management. In a nutshell,
> YaPPL is a message and file format that, in combination with the
> proposed service architecture, a) fulfills legal requirements for
> technically mediated consent provision, b) can act as an archive for
> expired preferences for auditing purposes, c) provides an enhanced
> user-centric access control model for future or unforeseen data
> processing requests. - Ulbricht & Pallas, 2018


## What is this?

This is a repository to make yappl-compatible transformation functions
available to the world.

Yappl allows for specifying things like:
"My *email* may be used for purpose p and utilizer u, but only if the
transformation *only_provider* is applied.
*ony_provider* would then be a tranformation functions that accepts an
email address as input and returns only the provider, not the actual
email address.

## How to use this?
Simply clone the repository and use the sample manifest.yml for every
function to deploy the function to your OpenWhisk installation using the
wskdeploy tool: `wskdeploy -m manifest.yml`

You can also of course add the functions to your existing manifest
files.

For further info see on OpenWhisk and wskdeploy see:
- [OpenWhisk](https://github.com/apache/incubator-openwhisk)
- [Whisk Deploy](https://github.com/apache/incubator-openwhisk-wskdeploy)

After deploying, you may use the provided request.json to see if it
works, e.g.:
`wsk action invoke anonymizer_demo/anonymizer -r -P request.json`

## Contributing
If you want to contribute functions to the store, simply add them to the
functions folder and store.json file.

All YaPPL Functions are openwhisk compatible functions. You can use any
compatible language (like JavaScript, Ruby and Swift).

YaPPL Transformation Functions need to adhere to the following
signature: `{ data: x } -> {data: x' }`, meaning that the expect input
to be a json object where the concerned data lies under a :data key.
Output needs to be json as well (or whatever your language's standard on
OpenWhisk is (Ruby Hash, Python Dictionary) and the updated data should
also be stored under the :data key.

For example, an `anonymizer.js` that replaces all string's characters
with *, would look like this:
```javascript
// demo yappl transformation function
// signature: transformation: { data: x } -> { data: x' }

// makes a *** string of the same length as input
function main (params) {
  let string = params.data
  let anonymized = "*".repeat(string.length)

  return { data: anonymized }
}
```

The function should be put into a subfolder of the functions folder:
`functions/anonymizer/anonymizer.js` and should also include a sample
wskdeploy manifest file:
```yaml
packages:
  anonymizer_demo:
    actions:
      anonymizer:
        function: anonymizer.js
```

Also add a demo request.json, like:
```json
{ "data": "some string" }
```

Lastly, add your function to the `store.json` file. The expected data
here is:
```json
{
  "functions": [
    ...,
    {
      "name": "anonymizer",
      "author": "your name / username / handle",
      "description": "This function replaces all string's characters with *",
      "compatibility": ["string"],
      "image_url": "http://link_to_pretty_image.com/image.png",
      "repo_link": "https://github.com/TPei/yappl_transformation_functions/tree/master/functions/anonymizer",
      "code_link": "https://github.com/TPei/yappl_transformation_functions/tree/master/functions/anonymizer/anonymizer.js"
    }
  ]
}
```

### What is compatibility?
To make usage of your functions easier, it's important to know what kind
of data they can handle. Since inputs are json objects, accepted data
types are:
- string
- number
- object
- array
- boolean
- null

To give further information, you may futher specify composite data
types, such as
- array(string)
- object(name: string, values: array(number))

If your function handles highly complex data objects, feel free to add a
README.md to your function folder explaining usage, giving examples etc.
