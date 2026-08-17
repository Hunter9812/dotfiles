#!/usr/bin/env bash

# Get the first audio card name dynamically.
CARD=$(pactl list cards short | awk 'NR==1 {print $2}')

# List profiles:
#   pactl list cards | sed -n '/Profiles:/,/Active Profile:/p'
# Profiles are provided by ALSA UCM.
SPEAKER_PROFILE="HiFi (HDMI1, HDMI2, HDMI3, Mic1, Mic2, Speaker)"
HEADPHONES_PROFILE="HiFi (HDMI1, HDMI2, HDMI3, Headphones, Mic1, Mic2)"

# List sink names:
#   pactl list sinks short | awk '/Speaker|Headphones/ {print $2}'
# Sink names are generated from the active profile.
SPEAKER_SINK="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink"
HEADPHONES_SINK="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Headphones__sink"

CURRENT_PROFILE=$(pactl list cards |
  sed -n "/$CARD/,/^Card #/p" |
  grep "Active Profile" |
  sed 's/.*Active Profile: //')

case "$CURRENT_PROFILE" in
  *Headphones*)
    echo "Switching to speakers..."

    pactl set-card-profile "$CARD" "$SPEAKER_PROFILE"
    sleep 1
    pactl set-default-sink "$SPEAKER_SINK"
    ;;

  *Speaker*)
    echo "Switching to headphones..."

    pactl set-card-profile "$CARD" "$HEADPHONES_PROFILE"
    sleep 1
    pactl set-default-sink "$HEADPHONES_SINK"
    ;;

  *)
    echo "Unknown profile:"
    echo "$CURRENT_PROFILE"
    exit 1
    ;;
esac
