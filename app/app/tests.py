"""
Sample Tests
"""

from django.test import SimpleTestCase

from app import calc

class CalcTest(SimpleTestCase):
    """ Test the calc function. """
    def test_add_numbers(self):
        """ Testing to add to numbers together """
        res = calc.add(5, 6)

        self.assertEqual(res, 11)

    def test_subtract_numbers(self):
        """ Testing to subtract two numbers from each other """
        res = calc.subtract(10, 15)

        self.assertEqual(res,9)
