# Football League Database

## Overview

The Football League Database project aims to create a comprehensive database for managing information related to a football league. This database is designed to facilitate the organization and administration of football competitions, specifically league championships. The primary goal is to provide a structured framework for conducting matches, recording results, and maintaining player statistics such as goals and assists.

## Features

- **Competition Structure Definition:** The project defines the structure of the competition, including the number of participating teams, the competition format (league or championship), match dates, and season schedules.

- **Team and Player Registration:** Every team and player involved in the league is registered in the database, including details such as name, date of birth, nationality, position, and contract details.

- **Statistical Evaluation:** The system allows for the tracking of team and player performances in competitions, recording both individual and collective statistics such as goals scored, assists provided, yellow and red cards received, minutes played, and clean sheets for goalkeepers.

- **Referee Management:** Referees are registered in the database, and the system enables the assignment of referees to matches, along with tracking their experience, performance history, and disciplinary actions.

- **Fixture Management:** The database manages fixtures, including match scheduling, venue allocation, and fixture updates such as postponements and rescheduling.

- **League Standings and Results:** The system calculates and updates league standings based on match results, providing real-time information on team rankings, points earned, goal differences, and form.

- **Transfer and Contract Management:** The database facilitates player transfers and contract negotiations, including transfer fees, contract durations, buyout clauses, and player loans.

## Database Schema

### Sequences

- SEQ_JUCATOR
- SEQ_ECHIPA
- SEQ_ANTRENOR
- SEQ_ARBITRU
- SEQ_STADION
- SEQ_ECHIPA_MECI
- SEQ_GOL
- SEQ_ASSIST
- SEQ_ARBITRARE_MECI
- SEQ_MECI

### Tables

- **STADION**
  - id_stadion (Primary Key)
  - nume_stadion
  - capacitate_stadion
  - adresa_stadion

- **ECHIPA**
  - id_echipa (Primary Key)
  - nume_echipa
  - oras
  - id_stadion (Foreign Key referencing STADION.id_stadion)
  - an_fondare
  - culoare_echipament

- **JUCATOR**
  - id_jucator (Primary Key)
  - id_echipa (Foreign Key referencing ECHIPA.id_echipa)
  - nume_jucator
  - prenume_jucator
  - varsta
  - data_nastere
  - nationalitate
  - pozitie
  - valoare_transfer
  - salariu

- **MECI**
  - id_meci (Primary Key)
  - data
  - id_stadion (Foreign Key referencing STADION.id_stadion)

- **ECHIPA_MECI**
  - id_echipa_meci (Primary Key)
  - id_meci (Foreign Key referencing MECI.id_meci)
  - id_echipa (Foreign Key referencing ECHIPA.id_echipa)
  - scor

- **ARBITRU**
  - id_arbitru (Primary Key)
  - nume_arbitru
  - meciuri_arbitrate
  - experienta_arbitru

- **ANTRENOR**
  - id_antrenor (Primary Key)
  - id_echipa (Foreign Key referencing ECHIPA.id_echipa)
  - nume_antrenor
  - prenume_antrenor
  - experienta_antrenor

- **ASSIST**
  - id_assist (Primary Key)
  - id_meci (Foreign Key referencing MECI.id_meci)
  - id_jucator (Foreign Key referencing JUCATOR.id_jucator)
  - minut_assist

- **GOL**
  - id_gol (Primary Key)
  - id_meci (Foreign Key referencing MECI.id_meci)
  - id_jucator (Foreign Key referencing JUCATOR.id_jucator)
  - minut_gol
  - tip_gol (penalty, free-kick, header, etc.)

- **ARBITRARE_MECI**
  - id_arbitrare_meci (Primary Key)
  - id_meci (Foreign Key referencing MECI.id_meci)
  - id_arbitru (Foreign Key referencing ARBITRU.id_arbitru)

### Data Insertions

- Sample data has been inserted into tables such as STADION, ECHIPA, JUCATOR, ARBITRU, ANTRENOR, MECI, GOL, ASSIST, ECHIPA_MECI, and ARBITRARE_MECI.

## Triggers

- **before_update_an_fond:** Prevents the modification of a team's founding year.

## Procedures and Functions

- **DetaliiJucatoriEchipa:** Displays detailed information about players in a given team.

- **detalii_meci_an:** Provides details about a match in a specific year.

- **detalii_meci_liga_fotbal:** Displays details about a football league match.

## Views

- **Clasament:** Provides a view of the current league standings, including team rankings, points, and goal differences.

- **TopJucatori:** Displays the top-performing players based on goals scored, assists provided, or other criteria.

- **MeciuriProgramate:** Shows upcoming fixtures and match schedules for the league.

