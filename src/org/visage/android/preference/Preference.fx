/*
 * Copyright (c) 2010-2011, Visage Project
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. Neither the name Visage nor the names of its contributors may be used
 *    to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
package org.visage.android.preference;

import org.visage.android.AndroidDelegate;
import org.visage.android.ContextAware;

/**
 * Represents the basic Preference UI building block displayed by a
 * {@link PreferenceActivity} in the form of a {@link org.visage.android.widget.ListView}.
 * This class provides the {@link org.visage.android.view.View} to be displayed
 * in the activity and associates with a <code>SharedPreferences</code> to
 * store/retrieve the preference data.
 * <p/>
 * When specifying a preference hierarchy in XML, each element can point to a
 * subclass of {@link Preference}, similar to the view hierarchy and layouts.
 * <p/>
 * This class contains a key that will be used as the key into the
 * <code>SharedPreferences</code>. It is up to the subclass to decide how to
 * store the value.
 *
 * @author Stephen Chin <steveonjava@gmail.com>
 */
public class Preference extends AndroidDelegate, ContextAware, android.preference.Preference.OnPreferenceChangeListener, android.preference.Preference.OnPreferenceClickListener {
    /**
     * Reference to the wrapped Android <code>Preference</code> class.
     */
    public-read var androidPreference = bind androidDelegate as android.preference.Preference on replace {
        androidPreference.setOnPreferenceChangeListener(this);
    }

    override function contextUpdated() {
        androidDelegate = new android.preference.Preference(context);
    }

    override function onPreferenceChange(preference:android.preference.Preference, newValue:Object):Boolean {
        if (onChange != null) onChange(newValue) else true;
    }

    override function onPreferenceClick(preference:android.preference.Preference):Boolean {
        if (onClick != null) onClick() else false;
    }


    /**
     * Called when a Preference has been changed by the user. This is called
     * before the state of the Preference is about to be updated and before the
     * state is persisted.
     * <p/>
     * Return true from this function to update the state of the Preference
     * with the new value, or false to veto the change.
     */
    public var onChange:function(value:Object):Boolean;

    /**
     * Called when a Preference has been clicked.
     * <p/>
     * Return true if the click was handled.
     */
    public var onClick:function():Boolean;

    /**
     * The default value for the preference, which will be set either if
     * persistence is off or persistence is on and the preference is not found
     * in the persistent storage.
     */
    public var defaultValue:Object on replace {
        if (isInitialized(defaultValue)) updateProperty(function() {
            androidPreference.setDefaultValue(defaultValue);
        });
    }

    /**
     * The key of another Preference that this Preference will depend on.
     * If the other Preference is not set or is off, this Preference will be
     * disabled.
     */
    public var dependency:String on replace {
        if (isInitialized(dependency)) updateProperty(function() {
            androidPreference.setDependency(dependency);
        });
    }

    /**
     * Whether the Preference is enabled.
     */
    public var enabled:Boolean on replace {
        if (isInitialized(enabled)) updateProperty(function() {
            androidPreference.setEnabled(enabled);
        });
    }

    /**
     * The key to store the Preference value.
     */
    public var key:String on replace {
        if (isInitialized(key)) updateProperty(function() {
            androidPreference.setKey(key);
        });
    }

    // todo - add in layout property

    /**
     * The order for the Preference (lower values are to be ordered first).
     * If this is not specified, the default ordering will be alphabetic.
     */
    public var order:Integer on replace {
        if (isInitialized(order)) updateProperty(function() {
            androidPreference.setOrder(order);
        });
    }

    /**
     * Whether the Preference stores its value to the shared preferences.
     */
    public var persistent:Boolean on replace {
        if (isInitialized(persistent)) updateProperty(function() {
            androidPreference.setPersistent(persistent);
        });
    }

    /**
     * Whether the Preference is selectable.
     */
    public var selectable:Boolean on replace {
        if (isInitialized(selectable)) updateProperty(function() {
            androidPreference.setSelectable(selectable);
        });
    }

    /**
     * Whether the view of this Preference should be disabled when this
     * Preference is disabled.
     */
    public var shouldDisableView:Boolean on replace {
        if (isInitialized(shouldDisableView)) updateProperty(function() {
            androidPreference.setShouldDisableView(shouldDisableView);
        });
    }

    /**
     * The summary for the Preference in a PreferenceActivity screen. 
     */
    public var summary:String on replace {
        if (isInitialized(summary)) updateProperty(function() {
            androidPreference.setSummary(summary);
        });
    }

    /**
     * The title for the Preference in a PreferenceActivity screen.
     */
    public default var title:String on replace {
        if (isInitialized(title)) updateProperty(function() {
            androidPreference.setTitle(title);
        });
    }

    // todo - add in widget layout property

    /**
     * Subclasses should override this function to take an action after
     * being added to the preference tree.
     */
    protected function preferenceAdded() {}
}
