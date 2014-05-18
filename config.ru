#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Padrino,
# just execute it from the command line.

require File.expand_path("../config/boot.rb", __FILE__)

map "/scoreboard" do
    secret_file_path = '/events/session_key'
    secret_key = "Ouppvx4UKRIJ7zHCDuFEYh7IOwaJ3dIClmROlIzj5Y5RkSVeN2CIZMOar6FxwYL"
    if File.exist? secret_file_path
      secret_key = File.read(secret_file_path).chomp
    end
    use Rack::Session::Cookie, key: "_sse_session",
                               secret: secret_key
    run Padrino.application
  end