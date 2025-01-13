#!/bin/bash

# Lancer le serveur de l'annuaire avec les arguments passés en paramètres
java -cp bin:lib/* fr.n7.hagimule.diary.DiaryServer "$@"