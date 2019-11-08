# RailsTickets

RailsTickets ist ein POC zur Verwaltung von Reklamationsfällen (Claims) im für Wareneingangsprozesse in Lagerhäusern. Die Anwendung ist als Machbarkeitsstudie/Prototyp konzipiert und nicht bereit für einen produktiven Einsatz.

## Technischer Hintergrund

RailsTickets wurde in Ruby on Rails 5.1.2 entwickelt und setzt Bootstrap 3.3.7 ein. Zur Verwaltung von hochgeladenen Dokumenten wird CarrierWave eingesetzt.

## Features

Die folgenden Funktionen sind im Prototyp enthalten:

* Benutzerverwaltung
* Verwaltung von Reklamationsfällen (Claims)
* Upload/Download von Bild- und Dokumentendateien für Claims
* Statusmodell für Claims
* Hinterlegen von Lösungen für einen Claim

## TODOs/Backlog

Die folgenden funktionalen/nicht funktionalen Anforderungen können in einem späteren Release eingearbeitet werden:

* Filterbare/ sortierbare Liste von Claims
* Attribut akzeptiert/nicht akzeptiert in der Claim-Lösung
* Suchfunktion für Claims
* Reportingfunktionalitäten auf Claimebene (Wie viele offene/in Bearbeitung/Bearbeitungsdauer, etc.)
* Ggf. überarbeitete Benutzerverwaltung/Authorisierung mit OmniAuth und Pundit einarbeiten
* Statusmodell ggf. mit FSM umsetzen
* Benutzervorgaben einarbeiten
* Fehlermeldungstexte ins Deutsche übersetzen
* Unit Tests/ Integrationstests einarbeiten (in das produktiv zu setzende Produkt)
* Nicht benötigte Routen/Controller-Actions/Views entfernen und Zugriff auf alle Views via Auth regeln
* Ggf. asynchrone Verarbeitung der Jobs zum Reporting (z.B. Sidekiq)
* Code auf Smells/Sicherheitslücken untersuchen
* Für die SQLs entsprechende Views in die DB bauen, um Queries zu vereinfachen
* Nicht benötigte Routen/Funktionalitäten entsorgen und aus dem Zugriff entziehen
* Reportingfunktionalität generisch implementieren, damit div. verschiedene Reports gehandlet werden können

## Zu beachten zum Connect gegen Oracle-DBs

Zum Connect gegen Oracle ist der folgende Guide einzuhalten, da Zusatzsoftware ausßerhalb der Anwendung benötigt wird. Dieser ist [hier](https://github.com/kubo/ruby-oci8/blob/master/docs/install-instant-client.md) zu finden.

### Benötigte Gems

  gem 'activerecord-oracle_enhanced-adapter', '~> 1.8.0'
  gem 'ruby-oci8'

### Zu setzendes ENV (.bashrc auf dem Entwicklungssystem)

  ORACLE_HOME=~/dev/prog/oracle/instantclient_12_2
  LD_LIBRARY_PATH=~/dev/prog/oracle/instantclient_12_2

## How to run

Sofern `rails` installiert ist, sollten die folgenden Befehle reichen:

1. Anwendung vorbereiten
```
bundle install
bin/rails db:migrate
bin/rails db:seed
```

2. Anwendung ausführen

Zum Ausführen der Anwendung entweder `foreman start -p <port>` oder `rails server` verwenden.
