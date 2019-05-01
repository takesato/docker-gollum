#!/usr/bin/env ruby
require 'rubygems'

module Gollum
  Gollum::GIT_ADAPTER = "rugged"
end

require 'gollum/app'
Dir.glob('./lib/**/*.rb') do |lib|
  require lib
end

Gollum::Hook.register(:post_commit, :push_after_commit) do |committer, sha1|
  `cd #{ENV['GOLLUM_HOME']} && git push -u origin master`
end

WIKI_OPTIONS = {
  host: "0.0.0.0",
  universal_toc: false,
  css: true,
  js: true,
  allow_editing: true,
  allow_uploads: true,
  per_page_uploads: true,
  mathjax: true,
  show_all: true,
  collapse_tree: true,
  h1_title: false,
  display_metadata: true,
  critic_markup: true,
  ref: 'master'
}

Precious::App.set(:gollum_path, ENV['GOLLUM_HOME'])
Precious::App.set(:default_markup, :markdown)
Precious::App.set(:wiki_options, WIKI_OPTIONS)
run Precious::App
