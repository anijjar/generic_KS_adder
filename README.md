# Generic Kogge-Stone Adder

This repo contains a generic KS adder.

The components names were taken from the [wikipedia page](https://en.wikipedia.org/wiki/Kogge%E2%80%93Stone_adder)

Note to self: The ISE syntheizer optimizes out the propagation bits of the lowest level because they are not being used anywhere. Maybe create new green and Yellow components for the last layer with the propagation outputs removed so that these info messages are not cluttering the console.