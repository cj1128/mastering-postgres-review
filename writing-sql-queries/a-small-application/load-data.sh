#!/bin/bash
createdb chinook
pgloader chinook.sqlite postgresql:///chinook
