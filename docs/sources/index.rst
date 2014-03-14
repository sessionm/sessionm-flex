###############################
 SessionM AIR Native Extension
###############################

The library can be added to your Maven POM file : ::

    <dependencies>
        [...]
        <dependency>
            <groupId>com.ludia.client</groupId>
            <artifactId>sessionm</artifactId>
            <version>${version}</version>
            <type>ane</type>
        </dependency>
    </dependencies>

where ``${version}`` is valid release number (current is |release|).

Under the hood, this extension uses the SessionM iOS SDK v1.9.3 and Android
SDK v1.8.1.

=====
Usage
=====

.. literalinclude:: ../../sessionm-example/src/main/flex/Main.as
    :start-after: /*doc-start
    :end-before: /*doc-end
    :append: }
