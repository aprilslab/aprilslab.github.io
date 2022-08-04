---
title: "[Kotlin] Custom EditText 만들기 (Two-Way Binding)"
date: 2022-08-04T13:08:05Z
draft: false
mermaid: true
math: true
menu:
  sidebar:
    name: "[Kotlin] Custom EditText 만들기 (Two-Way Binding)"
    identifier: aos-00
    parent: aos
    weight: 10
tags: ["Android", "Custom View", "Custom EditText", "Kotlin", "Two-Way Binding"]
categories: ["Android"]
---

## 무엇을 만들것인가?

안녕하세요.
오늘은 Two-Way binding이 가능한 Kotlin Custom EditText를 만들어볼 생각입니다.\
Android 에서 기본 제공되는 EditText는 포커스 됐을 때 진한 녹색 언더바가 생기는데 개인적 생각으로는 이쁘지 않기 때문에 포커스가 되면 언더라인 색이 바뀌는 EditText를 만들어볼 것입니다.

인터넷을 찾아 Custom View를 만드는 예시는 많이 나오지만 해당 예시를 따라하다보면 two-way binding이 안되는 경우가 많아 글을 작성하게 되었습니다.

android 의 layout 파일에서 `android:text="@{viewModel.name}"` 처럼 
viewModel의 데이터를 바인딩 할 수 있는데 `android:text="@={viewModel.name}"`와 같이 
@뒤에 =이 붙는 경우는 two-way binding이라고 합니다. 


## 최종 소스 코드

### `CustomUnderlineEditText`
```kotlin
import android.content.Context
import android.content.res.TypedArray
import android.text.Editable
import android.text.TextWatcher
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.view.inputmethod.EditorInfo
import android.widget.EditText
import android.widget.TextView
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.databinding.BindingAdapter
import androidx.databinding.InverseBindingAdapter
import androidx.databinding.InverseBindingListener
import androidx.databinding.adapters.ListenerUtil
import androidx.databinding.adapters.TextViewBindingAdapter
import com.foodtechkorea.bhc.R

class CustomUnderlineEditText : ConstraintLayout {
    companion object {
        @JvmStatic
        @BindingAdapter("android:text")
        fun setText(customEditText: CustomUnderlineEditText, text: String) {
            val oldValue = customEditText.text
            if (oldValue != text) {
                customEditText.text = text
            }
        }

        @JvmStatic
        @BindingAdapter("android:beforeTextChanged", "android:onTextChanged", "android:afterTextChanged", "android:textAttrChanged", requireAll = false)
        fun setTextWatcher(customEditText: CustomUnderlineEditText, before: TextViewBindingAdapter.BeforeTextChanged?,
                           on: TextViewBindingAdapter.OnTextChanged?, after: TextViewBindingAdapter.AfterTextChanged?,
                           textAttrChanged: InverseBindingListener?) {
            val newValue = object: TextWatcher {
                override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
                    before?.beforeTextChanged(s, start, count, after)
                }
                override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                    on?.onTextChanged(s, start, before, count)
                    textAttrChanged?.onChange()
                }

                override fun afterTextChanged(s: Editable?) {
                    after?.afterTextChanged(s)
                }
            }

            val oldValue = ListenerUtil.trackListener(customEditText, newValue, R.id.textWatcher)
            if (oldValue != null) {
                customEditText.editText.removeTextChangedListener(oldValue)
            }
            customEditText.editText.addTextChangedListener(newValue)
        }

        @JvmStatic
        @InverseBindingAdapter(attribute = "android:text", event = "android:textAttrChanged")
        fun getText(customEditText: CustomUnderlineEditText) : String {
            return customEditText.text
        }
    }

    var text: String
        get() = getText()
        set(value) {
            setText(value)
        }

    lateinit var editText: EditText
    lateinit var underLine: View

    constructor(context: Context) : super(context) {
        init(context)
    }
    constructor(context: Context, attrs: AttributeSet?) : super(context, attrs) {
        init(context)
        getAttrs(attrs)
    }
    constructor(context: Context, attrs: AttributeSet?, defStyleAttr: Int) : super(context, attrs, defStyleAttr) {
        init(context)
        getAttrs(attrs, defStyleAttr)
    }

    private fun init(context: Context) {
        val view = LayoutInflater.from(context).inflate(R.layout.custom_edittext, this, false)
        addView(view)

        editText = findViewById(R.id.changedColorEdtText)
        underLine = findViewById(R.id.underlineView)

        editText.setOnFocusChangeListener { _, hasFocus ->
            if (hasFocus) {
                underLine.setBackgroundResource(R.color.black_bhc)
            } else {
                underLine.setBackgroundResource(R.color.gray_bhc_background_img)
            }
        }
    }

    private fun getAttrs(attrs: AttributeSet?) {
        val typedArray = context.obtainStyledAttributes(attrs, R.styleable.customEditText)
        setTypedArray(typedArray)
    }
    private fun getAttrs(attrs: AttributeSet?, defStyleAttr: Int) {
        val typedArray = context.obtainStyledAttributes(attrs, R.styleable.customEditText, defStyleAttr, 0)
        setTypedArray(typedArray)
    }

    private fun setTypedArray(typedArray: TypedArray) {
        val hintResID: String? = typedArray.getString(R.styleable.customEditText_android_hint)
        editText.hint = hintResID

        val focusable: Boolean =
            typedArray.getBoolean(R.styleable.customEditText_android_focusable, true)
        editText.isFocusable = focusable

        val focusableInTouchMode: Boolean = typedArray.getBoolean(
            R.styleable.customEditText_android_focusableInTouchMode,
            true
        )
        editText.isFocusableInTouchMode = focusableInTouchMode

        val imeOptions: Int = typedArray.getInt(
            R.styleable.customEditText_android_imeOptions,
            EditorInfo.IME_ACTION_DONE
        )
        editText.imeOptions = imeOptions

        val inputType: Int = typedArray.getInt(
            R.styleable.customEditText_android_inputType,
            EditorInfo.TYPE_NULL
        )

        if (inputType != EditorInfo.TYPE_NULL) {
            editText.inputType = inputType
        }

        typedArray.recycle()
    }

    @JvmName("setText1")
    fun setText(text: String) {
        editText.setText(text)
    }

    fun setText(resId: Int) {
        editText.setText(resId)
    }

    fun setHint(hint: String) {
        editText.setHint(hint)
    }

    fun setHint(resId: Int) {
        editText.setHint(resId)
    }

    @JvmName("getText1")
    fun getText() : String {
        return editText.text.toString()
    }

    override fun clearFocus() {
        super.clearFocus()
        editText.clearFocus()
    }

    fun setOnEditorActionListener(listener: TextView.OnEditorActionListener) {
        editText.setOnEditorActionListener(listener)
    }
}
```

### `res/layout/custom_edittext.xml`
```xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="wrap_content">

    <androidx.appcompat.widget.AppCompatEditText
        android:id="@+id/changedColorEdtText"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:background="@null"
        android:inputType="text"
        android:maxLines="1"
        android:paddingTop="8dp"
        android:paddingBottom="16dp"
        app:layout_constraintTop_toTopOf="parent" />

    <View
        android:id="@+id/underlineView"
        android:layout_width="match_parent"
        android:layout_height="1dp"
        android:layout_marginBottom="8dp"
        android:background="@color/gray_bhc_background_img"
        app:layout_constraintBottom_toBottomOf="parent" />
</androidx.constraintlayout.widget.ConstraintLayout>
```


### `res/values/attrs.xml`
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <declare-styleable name="customEditText">
        <attr name="android:hint" />
        <attr name="android:inputType" />
        <attr name="android:imeOptions" />
        <attr name="android:focusable" />
        <attr name="android:focusableInTouchMode" />
    </declare-styleable>
</resources>
```