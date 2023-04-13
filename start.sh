#!/bin/bash
export DATABASE_URL="postgresql://localhost/airrent"
uvicorn main:app --reload