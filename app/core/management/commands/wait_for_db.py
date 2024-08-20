"""
Django command to wait for the databse to be available 

"""
import time
from psycopg2 import OperationalError as Psycopg2Error
from django.db.utils import OperationalError
from django.core.management import BaseCommand
from typing import Any

class Command(BaseCommand):
    """Django command to wait for database"""
    def handle(self, *args: Any, **options):
        self.stdout.write("waiting for database")
        db_up = False
        while not db_up:
            try:
                self.check(databases=['default'])
                db_up = True
            except (Psycopg2Error, OperationalError):
                self.stdout.write('Database unavailable, waiting 1 second ..')
                time.sleep(1)
        
        self.stdout.write(self.style.SUCCESS('Database available!'))
