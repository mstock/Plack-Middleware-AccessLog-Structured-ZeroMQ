package Plack::Middleware::AccessLog::Structured::ZeroMQ;
use parent qw(Plack::Middleware::AccessLog::Structured);

# ABSTRACT: Access log middleware which passes structured log messages into ZeroMQ

use strict;
use warnings;

use MRO::Compat;
use Message::Passing::Output::ZeroMQ;


=head1 SYNOPSIS

	use Plack::Middleware::AccessLog::Structured::ZeroMQ;

	Plack::Middleware::AccessLog::Structured::ZeroMQ->wrap($app,
		connect     => 'tcp://127.0.0.1:5552',
		callback    => sub {
			my ($env, $message) = @_;
			$message->{foo} = 'bar';
			return $message;
		},
		extra_field => {
			'some.application.field' => 'log_field',
			'some.psgi-env.field'    => 'another_log_field',
		},
	);

=head1 DESCRIPTION

Plack::Middleware::AccessLog::Structured::ZeroMQ is a
L<Plack::Middleware|Plack::Middleware> which sends structured, JSON-encoded log
messages into a ZeroMQ message queue.

=head1 METHODS

=head2 new

Constructor, creates new instance. See also the base class
L<Plack::Middleware::AccessLog::Structured|Plack::Middleware::AccessLog::Structured>
for additional parameters. Please note that you should not pass the C<logger>
parameter to Plack::Middleware::AccessLog::Structured::ZeroMQ as that would
override the default of passing log messages into ZeroMQ.

=head3 Parameters

This method expects its parameters as a hash reference.

=over

=item connect

The address of the ZeroMQ endpoint to send the data to. Defaults to
C<tcp://127.0.0.1:5552>.

=back

=head3 Result

A fresh instance of the middleware.

=cut

sub new {
	my ($class, $arg_ref) = @_;

	my $self = $class->next::method($arg_ref);

	my $output = Message::Passing::Output::ZeroMQ->new(
		connect => $self->{connect} || 'tcp://127.0.0.1:5552',
	);

	unless ($self->logger()) {
		$self->logger(sub {
			$output->consume(@_);
		});
	}

	return $self;
}


=head1 SEE ALSO

=over

=item *

L<Plack::Middleware|Plack::Middleware>

=item *

L<Plack::Middleware::AccessLog::Structured|Plack::Middleware::AccessLog::Structured>,
the base class for this middleware.

=item *

L<Message::Passing|Message::Passing>, especially
L<Message::Passing::Output::ZeroMQ|Message::Passing::Output::ZeroMQ> which is
used by this middleware.

=item *

L<Message::Passing::Output::ElasticSearch|Message::Passing::Output::ElasticSearch>
which can serve as an output for L<Message::Passing|Message::Passing> to store
the log messages into ElasticSearch.

=back

=cut

1;
