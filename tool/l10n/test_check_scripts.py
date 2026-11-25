import unittest
from check_scripts import unexpected


class ScriptRegressionTests(unittest.TestCase):
    def test_greek_action_rejects_arabic_letters(self):
        self.assertTrue(unexpected("Αναζήτηση λίستων", "el"))
        self.assertFalse(unexpected("Αναζήτηση λιστών", "el"))

    def test_malayalam_rejects_foreign_vowel_mark(self):
        self.assertTrue(unexpected("മാസവാരী", "ml"))
        self.assertFalse(unexpected("മാസത്തിലെ ചെലവ്", "ml"))

    def test_telugu_rejects_other_language_sentence(self):
        self.assertTrue(unexpected("แยกสำเนาเป็นสำเนาใหม่", "te"))
        self.assertFalse(unexpected("వేరే ప్రతిగా దిగుమతి చేయండి", "te"))

    def test_japanese_shared_prolongation_mark_is_valid(self):
        self.assertFalse(unexpected("スーパーのレシート", "ja"))

    def test_pashto_arabic_and_branding_are_valid(self):
        self.assertFalse(unexpected("NShoptor Pro پښتو", "ps"))

    def test_inherited_accent_and_latin_icu_are_valid(self):
        self.assertFalse(unexpected("Cre\u0300me {count} AI", "fr"))


if __name__ == "__main__":
    unittest.main()
