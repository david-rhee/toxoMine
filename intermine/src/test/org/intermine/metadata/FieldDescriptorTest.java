package org.flymine.metadata;

import junit.framework.TestCase;

import java.util.Collections;
import java.util.Set;

public class FieldDescriptorTest extends TestCase
{
    private static final Set EMPTY_SET = Collections.EMPTY_SET;

    public FieldDescriptorTest(String arg) {
        super(arg);
    }

    public void testConstructorNullName() throws Exception {
        try {
            new TestFieldDescriptor(null, false);
            fail("Expected IllegalArgumentException");
        } catch (IllegalArgumentException e) {
        }
    }

    public void testConstructorEmptylName() throws Exception {
        try {
            new TestFieldDescriptor("", false);
            fail("Expected IllegalArgumentException");
        } catch (IllegalArgumentException e) {
        }
    }

    public void testSetClassDescriptorNull() throws Exception {
        FieldDescriptor fd = new TestFieldDescriptor("name", false);
        try {
            fd.setClassDescriptor(null);
            fail("Expected NullPointerException");
        } catch (NullPointerException e) {
        }
    }

    public void testSetClassDescriptorValid() throws Exception {
        FieldDescriptor fd = new TestFieldDescriptor("name", false);
        ClassDescriptor cld = new ClassDescriptor("Class1", null, null, false,
                                                  EMPTY_SET, EMPTY_SET, EMPTY_SET);
        try {
            fd.setClassDescriptor(cld);
        } catch (IllegalStateException e) {
            fail("Unable to set ClassDescriptor");
        }
    }

    public void testSetClassDescriptorTwice() throws Exception {
        FieldDescriptor fd = new TestFieldDescriptor("name", false);
        ClassDescriptor cld = new ClassDescriptor("Class1", null, null, false,
                                                  EMPTY_SET, EMPTY_SET, EMPTY_SET);
        fd.setClassDescriptor(cld);
        try {
            fd.setClassDescriptor(cld);
            fail("Expected IllegalStateException");
        } catch (IllegalStateException e) {
        }
    }

    private class TestFieldDescriptor extends FieldDescriptor {
        public TestFieldDescriptor(String name, boolean primaryKey) {
            super(name, primaryKey);
        }

        public int relationType() {
            return FieldDescriptor.NOT_RELATION;
        }
    }
}
