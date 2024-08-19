"""
sample test
"""

from django.test import SimpleTestCase
from app import calc

class CalcTests(SimpleTestCase):
    """Test the clac module """

    def test_add_number(self):
        """Test adding numbers together"""
        res= calc.add(5,6)
        self.assertEqual(res, 11)
    
    def test_substract_numbers(self):
        """Test substracting number together"""
        res=calc.substract(10,5) 
        self.assertEqual(res, 5)
    
    def test_multiplay_numbers(self):
        res=calc.multiplay(2,4)
        self.assertEqual(res,8)
