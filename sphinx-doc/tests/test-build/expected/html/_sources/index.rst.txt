NDD Docker Sphinx Tests
=======================

.. toctree::
   :maxdepth: 2

   Markdown document <some-markdown-document.md>



recommonmark
------------

https://pypi.org/project/recommonmark/

See the document in the sidebar.



sphinx.ext.graphviz
-------------------

http://www.sphinx-doc.org/en/master/usage/extensions/graphviz.html

.. graphviz::

   digraph foo {
      "bar" -> "baz" -> "quux";
   }



sphinx.ext.ifconfig
-------------------

http://www.sphinx-doc.org/en/master/usage/extensions/ifconfig.html

The next line must be "OK":

.. ifconfig:: release in ('alpha', 'beta', 'rc')

   KO

.. ifconfig:: release in ('0.1.0', '1.0.0', '2.0.0')

   OK



sphinx.ext.imgmath OR sphinx.ext.mathjax
----------------------------------------

http://www.sphinx-doc.org/en/master/usage/extensions/math.html#module-sphinx.ext.mathjax
http://www.sphinx-doc.org/en/master/usage/extensions/math.html#module-sphinx.ext.imgmath

See https://github.com/sphinx-doc/sphinx/issues/2837

Since Pythagoras, we know that :math:`a^2 + b^2 = c^2`.

:math:`\underline{x}=[  x_{1}, ...,  x_{n}]^{T}`



sphinx.ext.todo
---------------

.. todo::

   Fix this thing!



sphinx.prompt
-------------

.. prompt:: bash

    cd <folder>
    cp <src> \
         <dst>
    cd -



sphinxcontrib.actdiag
---------------------

http://blockdiag.com/en/actdiag/sphinxcontrib.html

.. actdiag::

    actdiag admin {
      A -> B -> C;
    }



sphinxcontrib.blockdiag
-----------------------

http://blockdiag.com/en/blockdiag/sphinxcontrib.html

.. blockdiag::

    blockdiag admin {
      top_page -> config -> config_edit -> config_confirm -> top_page;
    }



sphinxcontrib.excel_table
-------------------------

https://pypi.org/project/sphinxcontrib-excel-table/

.. excel-table::
   :file: ./some-excel-document.xlsx



sphinxcontrib.googleanalytics
-----------------------------

https://pypi.python.org/pypi/sphinxcontrib-googleanalytics

Does not work ?!?! "Could not import extension sphinxcontrib.googleanalytic"



sphinxcontrib.googlechart
-------------------------

https://pypi.org/project/sphinxcontrib-googlechart/

Does not work ?!?! "Could not import extension sphinxcontrib.googlechart"

.. COMMENT piechart::

     dog: 100
     cat: 80
     rabbit: 40



sphinxcontrib.googlemaps
------------------------

https://pypi.org/project/sphinxcontrib-googlemaps/

Does not work ?!?! "Could not import extension sphinxcontrib.googlemaps"

.. COMMENT googlemaps:: Shinjuku Station



sphinxcontrib.nwdiag
--------------------

http://blockdiag.com/en/nwdiag/sphinxcontrib.html

.. nwdiag::

    nwdiag {
      network dmz {
          web01;
          web02;
      }
    }



sphinxcontrib.plantuml
----------------------

http://en.plantuml.com/

.. uml::

   @startuml

   user -> (use PlantUML)

   note left of user
      Hello!
   end note

   @enduml

.. uml::

      @startuml

      'style options
      skinparam monochrome true
      skinparam circledCharacterRadius 0
      skinparam circledCharacterFontSize 0
      skinparam classAttributeIconSize 0
      hide empty members

      class Car

      Driver - Car : drives >
      Car *- Wheel : have 4 >
      Car -- Person : < owns

      @enduml

.. uml::

      @startuml

      salt
      {
        Just plain text
        [This is my button]
        ()  Unchecked radio
        (X) Checked radio
        []  Unchecked box
        [X] Checked box
        "Enter text here   "
        ^This is a droplist^
      }

      @enduml



sphinxcontrib.rackdiag
----------------------

http://blockdiag.com/en/nwdiag/sphinxcontrib.html

.. rackdiag::

   diagram {
     rackheight = 12;

     1: UPS [height = 3];
     4: DB Server (Master)
     5: DB Server (Mirror)
     7: Web Server (1)
     8: Web Server (1)
     9: Web Server (1)
     10: LoadBalancer
   }



sphinxcontrib.seqdiag
---------------------

http://blockdiag.com/en/seqdiag/sphinxcontrib.html

.. seqdiag::

    seqdiag admin {
      A -> B -> C;
    }
