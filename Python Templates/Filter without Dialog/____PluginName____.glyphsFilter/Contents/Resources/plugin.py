# encoding: utf-8

###########################################################################################################
#
#
#	Filter without dialog Plugin
#
#	Read the docs:
#	https://github.com/schriftgestalt/GlyphsSDK/tree/master/Python%20Templates/Filter%20without%20Dialog
#
#
###########################################################################################################

from __future__ import division, print_function, unicode_literals
import objc
from GlyphsApp import *
from GlyphsApp.plugins import *

class ____PluginClassName____(FilterWithoutDialog):
	
	@objc.python_method
	def settings(self):
		self.menuName = Glyphs.localize({'en': u'My Filter', 'de': u'Mein Filter'})
		self.keyboardShortcut = None # With Cmd+Shift
	
	@objc.python_method
	def filter(self, layer, inEditView, customParameters):
		
		# Apply your filter code here
		
		print(layer, inEditView, customParameters)
	
	@objc.python_method
	def __file__(self):
		"""Please leave this method unchanged"""
		return __file__
	