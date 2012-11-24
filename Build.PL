
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "AnyEvent" => 0,
    "Carp" => 0,
    "File::Find" => 0,
    "File::Temp" => 0,
    "HTTP::Request::Common" => 0,
    "Message::Passing::Filter::Decoder::JSON" => 0,
    "Message::Passing::Input::ZeroMQ" => 0,
    "Message::Passing::Output::Test" => 0,
    "Module::Build" => "0.3601",
    "Plack::Test" => 0,
    "Test::Class" => 0,
    "Test::Deep" => 0,
    "Test::More" => 0,
    "Test::TCP" => 0
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Access log middleware which passes structured log messages into ZeroMQ",
  "dist_author" => [
    "Manfred Stock <mstock\@cpan.org>"
  ],
  "dist_name" => "Plack-Middleware-AccessLog-Structured-ZeroMQ",
  "dist_version" => "0.001000",
  "license" => "perl",
  "module_name" => "Plack::Middleware::AccessLog::Structured::ZeroMQ",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "MRO::Compat" => 0,
    "Message::Passing::Output::ZeroMQ" => 0,
    "Plack::Middleware::AccessLog::Structured" => 0,
    "parent" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
