# Alephant::Renderer

Render HTML snippets

[![Build Status](https://travis-ci.org/BBC-News/alephant-renderer.png?branch=master)](https://travis-ci.org/BBC-News/alephant-renderer)

[![Gem Version](https://badge.fury.io/rb/alephant-renderer.png)](http://badge.fury.io/rb/alephant-renderer)

## Installation

Add this line to your application's Gemfile:

    gem 'alephant-renderer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alephant-renderer

## Usage

```rb
require 'alephant/renderer'

Alephant::Renderer.create('foo_template', '/base/path', 'foo_model')
```

## Translations

Currently there is a simple implementation of the [i18n](https://github.com/svenfuchs/i18n) library that allows templates to be translated.

### Setup

You need the following directory structure inside of the folder that relates to the `base_path`:

```bash
components
├── locale
│   ├── en.yml
│   ├── cy.yml
```

The yaml configs must have the extension `.yml`.

### Yaml structure

The yaml translations files must follow the following structure:

```yaml
en:
	template_name:
		key: 'foo'
		sub:
			key: 'bar'

	another_template:
		key: 'baz'
```

The first node is the language code, then the next set of nodes are the names of the templates files that the translations apply to. This allows you to just reference the translation key in the templates without prefixing the name of the template.

### Usage

For each translation, a seperate model and view is needed.

#### Model

All that's needed in the model is to override the LOCALE constant:

```rb
class TestModel < Alephant::Views::Base
  LOCALE = :cy
end
```

#### Translations

The best approach with the templates when translations are needed, is to have a base template then a seperate one for each lanuage that's being translated.

In each view model, the following method is available for translations:

```ruby
t 'my_key'
```

#### Example

If we had a template called 'test_template.mustache' we would have the following in the model 'test_template.rb':

>test_template.rb

```ruby
def my_translation
	t 'key'
end
```

>test_template.mustache

```mustache
{{ my_translation }}
```

>locale/en.yml

```yaml
en:
    test_template:
		key: 'A translation!'
```

##### Default

By default, if the translation key doesn't exist then the translation key is used as the translation.

You can override this behaviour and provide a default:

```ruby
def my_translation
	t 'missing_key', :default => 'Some default'
end

```

So if the key doesn't exists, then 'Some default' is the translation.


## Contributing

1. Fork it ( http://github.com/bbc-news/alephant-renderer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
