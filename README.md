# README

Attention, this Rails app is not an actual app! It is nothing but material for a couple of 
blog posts on coding and refactoring, inspired by a technical test I stumbled upon.

The code presented here is the reproduction, from scratch, of the base material for the 
aforementioned technical test. The names and scenario (see below) have been changed to avoid 
any spoiling in case the original test is still online.

## Fictional context

We have opened a spa for Pokémons, where these cute creatures can enjoy a good rest 
between two battles. Because all Pokémon don't have arms or hands, they cannot check in 
or out themselves; for this reason, the entrance of the spa is equipped with a sensor 
that emits a _beep_ every time a given Pokémon enters or leaves. Our application provides 
an API that the sensor consumes to register these beeps, providing the ID of the Pokémon, 
the date and time of the beep, and its kind (checking in or out). The application also 
provides an endpoint to fetch a _summary_ of a given Pokémon's time spent at the spa, 
computed from its recorded beeps.

Pokémons are expected not to stay overnight, so each check-in beep _should_ eventually 
be matched by a check-out beep on the same day; however, network calls are notoriously 
unreliable, and data could be missed (i.e. some calls to the API may have never reached 
the application). For this reason, the summaries are expected to properly handle missing 
or inconsistent data:

-   Unpaired beeps are ignored when computing the total time spent.
-   Dates with unpaired beeps are returned in a dedicated section of the summary.

